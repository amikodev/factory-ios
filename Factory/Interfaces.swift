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

enum EquipmentType: String, Codable{
    case FreqConverter, CncRouter, Cnc5AxisRouter
}

protocol Equipment: Codable{
    var type: EquipmentType {get set}
    var name: String {get set}
    var caption: String {get set}
    var url: String {get set}
    var wsEnabled: Bool {get set}
    
    func setFrom(dict: [String: Any])
}

class EquipmentFreqConverter: Equipment, Codable{
    var type: EquipmentType = EquipmentType.FreqConverter
    var name: String = ""
    var caption: String = ""
    var url: String = ""
    var wsEnabled: Bool = false

    func setFrom(dict: [String: Any]){
        name = dict["name"] as! String
        caption = dict["caption"] as! String
        url = dict["url"] as! String
        wsEnabled = dict["wsEnabled"] as! Bool
    }
}

class EquipmentCncRouter: Equipment, Codable{
    var type: EquipmentType = EquipmentType.FreqConverter
    var name: String = ""
    var caption: String = ""
    var url: String = ""
    var wsEnabled: Bool = false

    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0

    func setFrom(dict: [String: Any]){
        name = dict["name"] as! String
        caption = dict["caption"] as! String
        url = dict["url"] as! String
        wsEnabled = dict["wsEnabled"] as! Bool
        
        x = dict["x"] as! Float
        y = dict["y"] as! Float
        z = dict["z"] as! Float
    }
}

class EquipmentCnc5AxisRouter: Equipment, Codable{
    var type: EquipmentType = EquipmentType.FreqConverter
    var name: String = ""
    var caption: String = ""
    var url: String = ""
    var wsEnabled: Bool = false

    func setFrom(dict: [String: Any]){
        name = dict["name"] as! String
        caption = dict["caption"] as! String
        url = dict["url"] as! String
        wsEnabled = dict["wsEnabled"] as! Bool
    }
}

protocol EquipmentDevice{
    
}

class UIEquipmentDeviceViewController: UIViewController{
    
    var _equipmentDict: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setEquipment(dict: [String: Any]){
        _equipmentDict = dict
    }
    
}




