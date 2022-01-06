/*
amikodev/factory-ios - Industrial equipment management with iOS mobile application
Copyright © 2022 Prihodko Dmitriy - asketcnc@yandex.ru
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

import UIKit
import Combine

class WifiMainController: UIViewController, IUIWifiForm {
    
    var wifiEquipment: IWifiEquipment?

    @IBOutlet weak var wifiModeButton: UIButton!
    @IBOutlet weak var wifiSsidTextField: UITextField!
    @IBOutlet weak var wifiPasswordTextField: UITextField!
    @IBOutlet weak var loaderView: UIView!
    
    var wifiMode: String = "STA"
    var wifiSsid: String = ""
    var wifiPassword: String = ""
    
    private var stream: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.wifiModeButton.setTitle("Mode: "+self.wifiMode, for: .normal)

        let modeSta = UIAction(title: "STA", image: UIImage(systemName: "wifi.circle")){ (action) in
            self.wifiMode = "STA"
            self.wifiModeButton.setTitle("Mode: "+self.wifiMode, for: .normal)
        }
        
        let modeAp = UIAction(title: "AP", image: UIImage(systemName: "wifi.circle.fill")){ (action) in
            self.wifiMode = "AP"
            self.wifiModeButton.setTitle("Mode: "+self.wifiMode, for: .normal)
        }
        
        let menu = UIMenu(title: "Wifi mode", options: .displayInline, children: [modeSta, modeAp])
        
        wifiModeButton?.menu = menu;
        wifiModeButton?.showsMenuAsPrimaryAction = true
        
        loaderView.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // start listeners

        stream = store.$state.sink {state in
            
            self.loaderView.isHidden = true
            
            let data: [UInt8] = state.deviceDataState.data
//            print("state.deviceDataState.data", data)
//            print("state", state)

            typealias WSE = WifiEquipment

            if(data.count == 16){

                if(data[0] == WSE.WS_OBJ_NAME_WIFI){
                    if(data[1] == WSE.WS_WIFI_SETTINGS){
                        if(data[2] == WS_CMD_READ){

                        }
                    }
                }

            } else if(data.count == 16+32){

                if(data[0] == WSE.WS_OBJ_NAME_WIFI){
                    if(data[1] == WSE.WS_WIFI_SETTINGS){
                        if(data[2] == WS_CMD_READ || data[2] == WS_CMD_WRITE){

                            let mode = data[3]

                            if(mode == WSE.WS_WIFI_MODE_STA){ self.wifiMode = "STA" }
                            else if(mode == WSE.WS_WIFI_MODE_AP){ self.wifiMode = "AP" }

                            self.wifiModeButton.setTitle("Mode: "+self.wifiMode, for: .normal)

                            let ssidBytes = data.dropFirst(16)
                            var wifiSsid: String = String(bytes: ssidBytes, encoding: .utf8)!
                            wifiSsid = wifiSsid.trimmingCharacters(in: CharacterSet(arrayLiteral: "\u{00}"))

                            self.wifiSsidTextField.text = wifiSsid
                            
                            if(data[2] == WS_CMD_WRITE){
                                DispatchQueue.main.async {
                                    self.navigationController?.dismiss(animated: true, completion: nil)
                                }
                            }

                        }
                    }
                }


            }
            
            
        }
        
        self.loaderView.isHidden = false
        self.wifiEquipment?.readSettings()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // stop listeners
        
        stream?.cancel()
        
    }
    

    
    @IBAction func ApplyButtonClick(_ sender: Any) {
        
        self.loaderView.isHidden = false
        self.wifiEquipment?.writeSettings(wifiMode: self.wifiMode, wifiSsid: self.wifiSsidTextField.text!, wifiPassword: self.wifiPasswordTextField.text!)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol IUIWifiForm{
    
    var wifiEquipment: IWifiEquipment? { get set}
    
}
