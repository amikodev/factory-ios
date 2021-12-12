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

class Application{
    
    public static var app = Application()
    
    private var _mainTabs: IMainTabs!
    private var _equipments: [[String: Any]] = []
    
    init(){
        
        updateEquipments()
        
    }
    
    func setMainTabs(tabs: IMainTabs){
        _mainTabs = tabs
    }
    
    func setEquipmentTab(equipmentDict: [String: Any]){
        _mainTabs.setEquipmentTab(equipmentDict: equipmentDict)
    }
    
    func getEquipments() -> [[String: Any]] {
        return _equipments
    }
    
    func updateEquipments(){

        _equipments = []

        let defaults = UserDefaults.standard

        var eqs = defaults.array(forKey: STORAGE_EQUIPMENTS)
        if(eqs == nil){
            eqs = [];
        }

        eqs?.forEach {el in
            let jsonStr = String(data: el as! Data, encoding: .utf8)
            let jsonData = jsonStr?.data(using: .utf8)
            
            let dict: [String: Any] = try! (JSONSerialization.jsonObject(with: jsonData!, options: []) as? [String: Any])!
            _equipments.append(dict)
        }

    }
    
    func addEquipment(jsonData: Data){
        let defaults = UserDefaults.standard
        
        var eqs = defaults.array(forKey: STORAGE_EQUIPMENTS)
        if(eqs == nil){
            eqs = []
        }

        eqs?.append(jsonData)

        defaults.set(eqs, forKey: STORAGE_EQUIPMENTS)
        updateEquipments()

    }
    
    func removeEquipment(index: Int){
        let defaults = UserDefaults.standard

        var eqs = defaults.array(forKey: STORAGE_EQUIPMENTS)
        if(eqs == nil){
            eqs = [];
        }

        if(index >= 0 && index < eqs!.count){
            eqs?.remove(at: index)
            defaults.set(eqs, forKey: STORAGE_EQUIPMENTS)
        }
        
        updateEquipments()
    }
    
}
