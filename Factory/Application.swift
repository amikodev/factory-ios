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

/**
 Application
 */
class Application{
    
    public static var app = Application()
    
    private var _equipments: [EquipmentDict] = []
    
    init(){
        
        refreshEquipments()
        
    }
    
    func getEquipments() -> [EquipmentDict] {
        return _equipments
    }
    
    /**
     Обновление списка используемого оборудования
     */
    func refreshEquipments(){

        _equipments = []

        let defaults = UserDefaults.standard

        var eqs = defaults.array(forKey: STORAGE_EQUIPMENTS)
        if(eqs == nil){
            eqs = [];
        }

        eqs?.forEach {el in
            _equipments.append((el as? EquipmentDict)!)
        }
        
    }
    
    /**
     Добавление нового оборудования
     */
    func addEquipment(data: EquipmentDict){
        let defaults = UserDefaults.standard
        
        var eqs = defaults.array(forKey: STORAGE_EQUIPMENTS)
        if(eqs == nil){
            eqs = []
        }

        eqs?.append(data)

//        print("addEquipment", eqs)

        defaults.set(eqs, forKey: STORAGE_EQUIPMENTS)
        refreshEquipments()

    }
    
    /**
     Сохранение параметров оборудования на основе uuid
     */
    func saveEquipment(data: EquipmentDict){
        let defaults = UserDefaults.standard
        
        var eqs = defaults.array(forKey: STORAGE_EQUIPMENTS)
        if(eqs == nil){
            eqs = []
        }
        
        eqs = eqs?.map { el in
            let e: EquipmentDict = (el as? EquipmentDict)!
            let u1 = e["uuid"] as? String
            let u2 = data["uuid"] as? String
            if(u1 == u2){
                return data
            }
            return el
        }
        
//        print("saveEquipment", eqs)

        defaults.set(eqs, forKey: STORAGE_EQUIPMENTS)
        refreshEquipments()
        
    }
    
    /**
     Удаление оборудования
     */
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
        
        refreshEquipments()
    }
    
}
