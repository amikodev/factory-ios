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

import UIKit
import SideMenu

class FreqConverterFormController: UIEquipmentFormController, IUIAddEquipment, IUIUpdateEquipment, IUIWifiForm {

    var wifiEquipment: IWifiEquipment?

    @IBAction func createClick(_ sender: UIButton) {
        
        var equipmentDict: EquipmentDict = EquipmentDict()
        equipmentDict["type"] = EquipmentType.FreqConverter.rawValue
        
        create(dict: &equipmentDict)

        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func saveClick(_ sender: UIButton){
        
        save(dict: &_equipment)

        // скрыть меню
        let sideMenuController = self.navigationController as? SideMenuNavigationController
        sideMenuController?.dismiss(animated: true, completion: nil)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.destination.children[0] is IUIWifiForm){
            var wf: IUIWifiForm = segue.destination.children[0] as! IUIWifiForm
            wf.wifiEquipment = wifiEquipment
        }
        
    }

}


class FreqConverterCreateFormController: FreqConverterFormController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isCreateForm = true
    }
    
}

