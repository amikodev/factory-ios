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

class CncRouterFormController: UIEquipmentFormController, IUIAddEquipment, IUIUpdateEquipment {

    @IBOutlet weak var sizeX: UITextField!
    @IBOutlet weak var sizeY: UITextField!
    @IBOutlet weak var sizeZ: UITextField!


    @IBAction func createClick(_ sender: UIButton) {
        
        var equipmentDict: EquipmentDict = EquipmentDict()
        equipmentDict["type"] = EquipmentType.CncRouter.rawValue
        
        equipmentDict["x"] = (sizeX.text! as NSString).floatValue
        equipmentDict["y"] = (sizeY.text! as NSString).floatValue
        equipmentDict["Z"] = (sizeZ.text! as NSString).floatValue

        create(dict: &equipmentDict)

        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func saveClick(_ sender: UIButton){
        
        save(dict: &_equipment)
        
    }

}


class CncRouterCreateFormController: CncRouterFormController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isCreateForm = true
    }
    
}

