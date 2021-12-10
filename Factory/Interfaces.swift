//
//  Interfaces.swift
//  Factory
//
//  Created by Dmitriy Prihodko on 04.12.2021.
//

import Foundation
import UIKit

let STORAGE_EQUIPMENTS = "Equipments"

protocol IMainTabs{
    func setEquipmentTab(title: String)
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
}

class EquipmentFreqConverter: Equipment, Codable{
    var type: EquipmentType = EquipmentType.FreqConverter
    var name: String = ""
    var caption: String = ""
    var url: String = ""
    var wsEnabled: Bool = false
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
}

class EquipmentCnc5AxisRouter: Equipment, Codable{
    var type: EquipmentType = EquipmentType.FreqConverter
    var name: String = ""
    var caption: String = ""
    var url: String = ""
    var wsEnabled: Bool = false
}




