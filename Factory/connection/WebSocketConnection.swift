/*
amikodev/factory-ios - Industrial equipment management with iOS mobile application
Copyright © 2021-2022 Prihodko Dmitriy - asketcnc@yandex.ru
*/

/*
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import Foundation


let WS_OBJ_NAME_DEVICE: UInt8 = 0x50


let WS_CMD_READ: UInt8 = 0x01
let WS_CMD_WRITE: UInt8 = 0x02




class WebSocketConnection: NSObject, IConnection, URLSessionWebSocketDelegate{
    
    var _url: String?
    
    var webSocketTask: URLSessionWebSocketTask!
    
    var _onSuccessConnectFunc: () -> Void = { }
    var _onErrorConnectFunc: () -> Void = { }
    var _onSuccessDisconnectFunc: () -> Void = { }
    var _onErrorSendFunc: () -> Void = { }
    var _onReceiveFunc: (_ data: Data) -> Void = { data in }

    required init(url: String){
        super.init()
        
        _url = url
        
        let queue = OperationQueue()
        var request = URLRequest(url: URL(string: _url!)!)
        request.networkServiceType = .responsiveData
        request.timeoutInterval = 5
        
        let urlSession = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: queue)
        webSocketTask = urlSession.webSocketTask(with: request)
        
    }
    
    
    func connect(){
        listen()
        webSocketTask.resume()
    }
    
    func disconnect(){
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }


    func send(data: Any){
        if((data as? Data) != nil){
            webSocketTask.send(URLSessionWebSocketTask.Message.data(data as! Data)) { error in
                self._onErrorSendFunc()
            }
        }
    }

    
    func onSuccessConnect(callback: @escaping () -> Void){
        _onSuccessConnectFunc = callback
    }
    
    func onErrorConnect(callback: @escaping () -> Void){
        _onErrorConnectFunc = callback
    }
    
    func onSuccessDisconnect(callback: @escaping () -> Void){
        _onSuccessDisconnectFunc = callback
    }
    
    func onErrorSend(callback: @escaping () -> Void){
        _onErrorSendFunc = callback
    }
    
    func onReceive(callback: @escaping (_ data: Data) -> Void){
        _onReceiveFunc = callback
    }

    

    private func listen(){
        
        webSocketTask.receive { result in
//            print("webSocketTask result: ", result)
            switch result {
                case .failure(let error):
                    self._onErrorConnectFunc()
                case .success(let message):
                    switch message {
                        case .data(let data):
//                            print("Reveived binary message: \(data)")
                            self._onReceiveFunc(data)
                        case .string(let text):
                            print("Reveived text message: \(text)")
                        @unknown default:
                            print("Unknown default on message")
                    }
                    self.listen()
            }
        }
        
    }
    
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        _onSuccessConnectFunc()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        _onSuccessDisconnectFunc()
    }

}
