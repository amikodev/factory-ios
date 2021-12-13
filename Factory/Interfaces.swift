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

let STORAGE_EQUIPMENTS = "Equipments"

protocol IMainTabs{
    func setEquipmentTab(equipmentDict: [String: Any])
}


protocol IAddEquipment{
    
    func createClick(_ sender: UIButton)

}

protocol IUpdateEquipment{
    
    func saveClick(_ sender: UIButton)
    func setEquipment(dict: EquipmentDict)
    
}

enum EquipmentType: String, Codable{
    case FreqConverter, CncRouter, Cnc5AxisRouter
}

typealias EquipmentDict = [String: Any]



protocol EquipmentDevice{
    
}

class UIEquipmentDeviceViewController: UIViewController{

    @IBOutlet weak var WebSocketStatusView: UIView!

    var _equipmentDict: EquipmentDict?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setEquipment(dict: EquipmentDict){
        _equipmentDict = dict
    }
    
}




