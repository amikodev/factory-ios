//
//  MainTabsController.swift
//  Factory
//
//  Created by Dmitriy Prihodko on 03.12.2021.
//

import UIKit

let EQUIPMENT_TAB = 1


class MainTabsController: UITabBarController, IMainTabs {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Application.app.setMainTabs(tabs: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setEquipmentTab(title: String) {
        let equipmentTab: UITabBarItem = self.tabBar.items![EQUIPMENT_TAB] as UITabBarItem;

        equipmentTab.isEnabled = true;
        equipmentTab.title = title;
        selectedIndex = EQUIPMENT_TAB
        
        let storyboard = UIStoryboard(name: "Cnc5AxisRouter", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: "MainController")
        
        navController.tabBarItem.title = title
        navController.children[0].navigationItem.title = title
        
        viewControllers?[EQUIPMENT_TAB] = navController
    }


}
