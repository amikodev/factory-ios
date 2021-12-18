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


/**
 Текущее оборудование
 */

struct CurrentEquipmentState: ReduxState{
    static var initialState: CurrentEquipmentState{
        .init(equipmentDict: EquipmentDict(), isSelected: false)
    }
    let equipmentDict: EquipmentDict
    let isSelected: Bool
}

enum CurrentEquipmentAction: ReduxAction{
    case change(dict: EquipmentDict)
    case select(dict: EquipmentDict)
}

struct CurrentEquipmentReducer: ReduxReducer{
    
    func reduce(state: CurrentEquipmentState?, action: ReduxAction?) -> CurrentEquipmentState{
        let currentState = state ?? CurrentEquipmentState.initialState
        
        guard let action = action as? CurrentEquipmentAction else {
            return currentState
        }
        
        switch action {
            case .change(let dict): return CurrentEquipmentState(equipmentDict: dict, isSelected: false)
            case .select(let dict): return CurrentEquipmentState(equipmentDict: dict, isSelected: true)
        }
    }

}



