/*
amikodev/factory-ios - Industrial equipment management with iOS mobile application
Copyright © 2022 Prihodko Dmitriy - asketcnc@yandex.ru
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

struct DeviceDataState: ReduxState{
    static var initialState: DeviceDataState{
        .init(data: [])
    }
    let data: [UInt8]
}

enum DeviceDataAction: ReduxAction{
    case receive(data: [UInt8])
}

struct DeviceDataReducer: ReduxReducer{
    
    func reduce(state: DeviceDataState?, action: ReduxAction?) -> DeviceDataState {
        let currentState = state ?? DeviceDataState.initialState
        
        guard let action = action as? DeviceDataAction else {
            return currentState
        }
        
        switch action{
            case .receive(let data): return DeviceDataState(data: data)
        }
    }
    
}

