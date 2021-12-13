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

class FreqConverterFormController: UIViewController, IAddEquipment, IUpdateEquipment {

    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var wsEnabled: UISwitch!
    
    private var _equipment: EquipmentDict = EquipmentDict()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        caption.text = _equipment["caption"] as? String
        url.text = _equipment["url"] as? String
        wsEnabled.isOn = _equipment["wsEnabled"] as! Bool
        
    }
    
    func setEquipment(dict: EquipmentDict){
        _equipment = dict
    }


    @IBAction func createClick(_ sender: UIButton) {

        let uuid = UUID.init().uuidString

        var equipmentDict: EquipmentDict = EquipmentDict()
        equipmentDict["type"] = "FreqConverter"
        equipmentDict["uuid"] = uuid
        equipmentDict["name"] = ""
        equipmentDict["caption"] = caption.text!
        equipmentDict["url"] = url.text!
        equipmentDict["wsEnabled"] = wsEnabled.isOn
        Application.app.addEquipment(data: equipmentDict)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func saveClick(_ sender: UIButton){
        
        var equipmentDict = _equipment
        equipmentDict["name"] = ""
        equipmentDict["caption"] = caption.text!
        equipmentDict["url"] = url.text!
        equipmentDict["wsEnabled"] = wsEnabled.isOn
        Application.app.saveEquipment(data: equipmentDict)

    }



}
