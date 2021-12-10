//
//  Application.swift
//  Factory
//
//  Created by Dmitriy Prihodko on 03.12.2021.
//

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
    
    func setEquipmentTab(title: String){
        _mainTabs.setEquipmentTab(title: title)
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
