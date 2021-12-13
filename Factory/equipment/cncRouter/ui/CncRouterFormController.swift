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

import UIKit

class CncRouterFormController: UIViewController, IAddEquipment, IUpdateEquipment {

    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var wsEnabled: UISwitch!
    
    @IBOutlet weak var sizeX: UITextField!
    @IBOutlet weak var sizeY: UITextField!
    @IBOutlet weak var sizeZ: UITextField!

    
    private var _equipment: EquipmentDict = EquipmentDict()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setEquipment(dict: EquipmentDict){
        _equipment = dict
        
        print("setEquipment", _equipment)
    }

    @IBAction func createClick(_ sender: UIButton) {
        
        var equipmentDict: EquipmentDict = EquipmentDict()
        equipmentDict["type"] = "FreqConverter"
        equipmentDict["name"] = ""
        equipmentDict["caption"] = caption.text!
        equipmentDict["url"] = url.text!
        equipmentDict["wsEnabled"] = wsEnabled.isOn
        equipmentDict["x"] = (sizeX.text! as NSString).floatValue
        equipmentDict["y"] = (sizeY.text! as NSString).floatValue
        equipmentDict["Z"] = (sizeZ.text! as NSString).floatValue
        Application.app.addEquipment(data: equipmentDict)
        

        
//        let equipment = EquipmentCncRouter()
//        equipment.type = EquipmentType.CncRouter
//        equipment.name = ""
//        equipment.caption = caption.text!
//        equipment.url = url.text!
//        equipment.wsEnabled = wsEnabled.isOn
//        equipment.x = (sizeX.text! as NSString).floatValue
//        equipment.y = (sizeY.text! as NSString).floatValue
//        equipment.z = (sizeZ.text! as NSString).floatValue
//
//        Application.app.addEquipment(jsonData: try! JSONEncoder().encode(equipment))

        self.navigationController?.popToRootViewController(animated: true)
        
    }

    @IBAction func saveClick(_ sender: UIButton){
        
    }


}
