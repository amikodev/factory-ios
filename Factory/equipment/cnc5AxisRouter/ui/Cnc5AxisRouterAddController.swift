//
//  Cnc5AxisRouterAddController.swift
//  Factory
//
//  Created by Dmitriy Prihodko on 04.12.2021.
//

import UIKit

class Cnc5AxisRouterAddController: UIViewController, IAddEquipment {

    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var wsEnabled: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func createClick(_ sender: UIButton) {
        
        let equipment = EquipmentCnc5AxisRouter()
        equipment.type = EquipmentType.Cnc5AxisRouter
        equipment.name = ""
        equipment.caption = caption.text!
        equipment.url = url.text!
        equipment.wsEnabled = wsEnabled.isOn
        
        Application.app.addEquipment(jsonData: try! JSONEncoder().encode(equipment))

        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}
