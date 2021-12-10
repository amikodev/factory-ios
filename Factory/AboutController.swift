//
//  About2Controller.swift
//  Factory
//
//  Created by Dmitriy Prihodko on 09.12.2021.
//

import UIKit

class AboutController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let name: String?
        switch(row){
            case 0: name = "FreqConverter"
            case 1: name = "CncRouter"
            case 2: name = "Cnc5AxisRouter"
            default: name = ""
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: name!, for: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//@interface About2Controller: UITableViewController

