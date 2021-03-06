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

let EQUIPMENT_TAB = 1


class MainTabsController: UITabBarController, IMainTabs {

    private var stream: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
        stream = store.$state.sink {state in
            let equipmentDict: EquipmentDict = state.currentEquipmentDict.equipmentDict
            if(!equipmentDict.isEmpty){
                if(state.currentEquipmentDict.isSelected){
                    self.setEquipmentTab(equipmentDict: equipmentDict)
                }
                self.updateEquipmentTab(equipmentDict: equipmentDict)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // stop listeners

        stream?.cancel()
        
    }
    
    

    
    func setEquipmentTab(equipmentDict: EquipmentDict){
        
        let type = equipmentDict["type"] as? String ?? ""
        let caption: String = equipmentDict["caption"] as? String ?? ""

        let storyboardName: String = type
        let title = caption

        let equipmentTab: UITabBarItem = self.tabBar.items![EQUIPMENT_TAB] as UITabBarItem

        equipmentTab.isEnabled = true
        equipmentTab.title = title
        selectedIndex = EQUIPMENT_TAB
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: "MainController")
        
        navController.tabBarItem.title = title
        
        viewControllers?[EQUIPMENT_TAB] = navController

    }
    
    func updateEquipmentTab(equipmentDict: EquipmentDict){
        let caption: String = equipmentDict["caption"] as? String ?? ""
        let equipmentTab: UITabBarItem = self.tabBar.items![EQUIPMENT_TAB] as UITabBarItem
        equipmentTab.title = caption
    }
    
}
