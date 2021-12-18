/*
amikodev/factory-ios - Industrial equipment management with iOS mobile application
Copyright © 2021 Prihodko Dmitriy - asketcnc@yandex.ru
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
    func setEquipmentTab(equipmentDict: [String: Any])
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

typealias EquipmentDict = [String: Any]



protocol EquipmentDevice{
    
}

class UIEquipmentDeviceViewController: UIViewController{

    @IBOutlet weak var WebSocketStatusView: UIView!

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
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // stop listeners
        
        store.dispatch(CurrentEquipmentAction.change(dict: _equipmentDict!))
        
        stream?.cancel()
        
    }
    
}


protocol IEquipmentForm{
    
//    func setEquipment(dict: EquipmentDict)
    func create(dict: inout EquipmentDict)
    func save(dict: inout EquipmentDict)
    
}

class UIEquipmentFormController: UIViewController, IEquipmentForm{
    
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var wsEnabled: UISwitch!
    
    var isCreateForm: Bool = false
    var _equipment: EquipmentDict = EquipmentDict()
    
    private var stream: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(isCreateForm){
            return
        }

        // start listeners

        stream = store.$state.sink {state in
            
            let equipmentDict: EquipmentDict = state.currentEquipmentDict.equipmentDict
            
            if(!equipmentDict.isEmpty){
                DispatchQueue.main.async {
                    self._equipment = equipmentDict
                    self.fillUIFields()
                }
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if(isCreateForm){
            return
        }

        // stop listeners
        
        stream?.cancel()
        
    }
    
    private func fillUIFields(){

        if(_equipment.count == 0){
            return
        }

        caption.text = _equipment["caption"] as? String
        url.text = _equipment["url"] as? String
        wsEnabled.isOn = _equipment["wsEnabled"] as! Bool

    }

    func create(dict: inout EquipmentDict){
        
        let uuid = UUID.init().uuidString

        dict["uuid"] = uuid
        dict["name"] = ""
        dict["caption"] = caption.text!
        dict["url"] = url.text!
        dict["wsEnabled"] = wsEnabled.isOn

        Application.app.addEquipment(data: dict)

    }
    
    func save(dict: inout EquipmentDict){
        
        dict["name"] = ""
        dict["caption"] = caption.text!
        dict["url"] = url.text!
        dict["wsEnabled"] = wsEnabled.isOn
        
        Application.app.saveEquipment(data: dict)
        
        store.dispatch(CurrentEquipmentAction.change(dict: dict))

    }



}




