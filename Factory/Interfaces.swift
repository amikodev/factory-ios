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
import UIKit
import Combine

let STORAGE_EQUIPMENTS = "Equipments"

protocol IMainTabs{
    func setEquipmentTab(equipmentDict: EquipmentDict)
    func updateEquipmentTab(equipmentDict: EquipmentDict)
}


protocol IUIAddEquipment{
    
    func createClick(_ sender: UIButton)

}

protocol IUIUpdateEquipment{
    
    func saveClick(_ sender: UIButton)
    
}

enum EquipmentType: String{
    case FreqConverter
    case CncRouter
    case Cnc5AxisRouter
}

enum DeviceConnectionType{
    case WebSocket
    case Http
}

typealias EquipmentDict = [String: Any]



protocol IEquipmentDevice{
    
    // соединение
    var _connection: IConnection? { get set }

}

protocol ISubEquipmentDevice: IEquipmentDevice{
    
}

class UIEquipmentDeviceViewController: UIViewController{

    @IBOutlet weak var ConnectionStatusView: UIView!

    var _equipmentDict: EquipmentDict?

    private var stream: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // start listeners
        
        stream = store.$state.sink {state in
            let equipmentDict: EquipmentDict = state.currentEquipmentDict.equipmentDict
            if(!equipmentDict.isEmpty){
                self._equipmentDict = equipmentDict
            }
            self.navigationItem.title = equipmentDict["caption"] as? String
            
            if(state.currentEquipmentDict.isSelected){
                DispatchQueue.main.async {
                    if(self._equipmentDict != nil){
                        store.dispatch(CurrentEquipmentAction.change(dict: self._equipmentDict!))

                    }

                }
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // stop listeners
        
        stream?.cancel()
        
    }
    
    func connectionListenStart(connection: IConnection?){
        connection?.onSuccessConnect {
            DispatchQueue.main.async {
                self.ConnectionStatusView.backgroundColor = .systemGreen
            }
        }
        
        connection?.onReceive { data in
            let arr: [UInt8] = [UInt8].init(data)
            print("receive data: ", arr)
            DispatchQueue.main.async {
                store.dispatch(DeviceDataAction.receive(data: arr))
                store.dispatch(DeviceDataAction.receive(data: []))
            }
        }
    }
    
    func connectionListenStop(connection: IConnection?){

        connection?.onSuccessConnect { }

    }
    
}


protocol IEquipmentForm{
    
    func create(dict: inout EquipmentDict)
    func save(dict: inout EquipmentDict)
    
}

protocol IConnection{
    
    var _url: String? { get set }
    
    var _onSuccessConnectFunc: () -> Void { get set }
    var _onErrorConnectFunc: () -> Void { get set }
    var _onSuccessDisconnectFunc: () -> Void { get set }
    var _onErrorSendFunc: () -> Void { get set }
    var _onReceiveFunc: (_ data: Data) -> Void { get set }

    
    init(url: String)
    
    func connect()
    func disconnect()
    func send(data: Any)

    func onSuccessConnect(callback: @escaping () -> Void)
    func onErrorConnect(callback: @escaping () -> Void)
    func onSuccessDisconnect(callback: @escaping () -> Void)
    func onErrorSend(callback: @escaping () -> Void)
    func onReceive(callback: @escaping (_ data: Data) -> Void)
    
    
}


class WsDefaultProtocol: IEquipmentDevice{

    var _connection: IConnection?
    
    init(url: String){
        _connection = WebSocketConnection(url: url)
    }
    
    init(connection: IConnection?){
        _connection = connection
    }

    func prepareData(preData: [UInt8]) -> [UInt8]{
        var arr: [UInt8] = [UInt8](repeating: 0x00, count: 16)
        
        let l = min(preData.count, 16)
        for i in (0...l-1){
            arr[i] = preData[i]
        }
        
        return arr
    }
    
    func prepareData(text: String, count: Int) -> [UInt8]{

        var arr: [UInt8] = [UInt8](text.utf8)
        if(arr.count > count){
            arr = arr.dropLast(arr.count-count)
        } else if(arr.count < count){
            arr += [UInt8](repeating: 0x00, count: (count-arr.count))
        }

        return arr;
    }
    
    func send(data: [UInt8]){
        _connection?.send(data: Data(prepareData(preData: data)))
    }
    
    func sendRaw(data: [UInt8]){
        _connection?.send(data: Data(data))
    }
        
}




