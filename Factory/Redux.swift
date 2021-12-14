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
 Redux
 */

public protocol ReduxState{
    
}

public protocol ReduxAction{
    
}

public protocol ReduxStore: ObservableObject{
    
    associatedtype S: ReduxState
    
    var state: S { get }
    
    func dispatch(_ action: ReduxAction)
    
}

public protocol ReduxReducer{
    
    associatedtype S: ReduxState
    
    func reduce(state: S?, action: ReduxAction?) -> S
    
}

open class Store<AppState, RootReducer>: ReduxStore
    where RootReducer: ReduxReducer,
    RootReducer.S == AppState
{
    
    @Published
    private(set) public var state: AppState
    
    private let rootReducer: RootReducer
    
    init(initialState: S, rootReducer: RootReducer){
        self.state = initialState
        self.rootReducer = rootReducer
    }
    
    public func dispatch(_ action: ReduxAction) {
        state = rootReducer.reduce(state: state, action: action)
    }
    
}

struct CounterState: ReduxState{
    static var initialState: CounterState{
        .init(count: 0)
    }
    let count: Int
}

struct AppState: ReduxState{
    let counterState: CounterState
}

struct RootReducer: ReduxReducer{
    let counterReducer: CounterReducer
    
    func reduce(state: AppState?, action: ReduxAction?) -> AppState {
        return AppState(
            counterState: counterReducer.reduce(state: state?.counterState, action: action)
        )
    }
    
}

enum CounterAction: ReduxAction{
    case increase
    case decrease
}

struct CounterReducer: ReduxReducer{
    
    func reduce(state: CounterState?, action: ReduxAction?) -> CounterState{
        let currentState = state ?? CounterState.initialState
        
        guard let action = action as? CounterAction else {
            return currentState
        }
        
        switch action {
            case .increase: return increaseCounter(for: currentState)
            case .decrease: return decreaseCounter(for: currentState)
        }
    }

    private func increaseCounter(for state: CounterState) -> CounterState{
        CounterState(count: state.count + 1)
    }
    
    private func decreaseCounter(for state: CounterState) -> CounterState{
        CounterState(count: state.count - 1)
    }
    
}

typealias AppStore = Store<AppState, RootReducer>

let store: AppStore = AppStore(
    initialState: AppState(
        counterState: .initialState
    ),
    rootReducer: RootReducer(
        counterReducer: .init()
    )
)
