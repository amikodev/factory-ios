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
import Combine

class ViewController: UIViewController {
    

    @IBOutlet weak var lbl: UILabel!
    
    private var stream: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stream = store.$state.sink {state in
//            print("view", state)
            self.lbl.text = String(state.counterState.count)
//            print("qw", state.currentEquipmentDict.equipmentDict["a"] as? Int)
        }
        
    }
    
    @IBAction func btnCick(_ sender: Any) {
        
        store.dispatch(CounterAction.increase)
        
        
        var dict: EquipmentDict = EquipmentDict()
        dict["a"] = 1
        dict["b"] = 2
        
//        store.dispatch(CurrentEquipmentAction.change(dict: dict))
        
    }
    
}

