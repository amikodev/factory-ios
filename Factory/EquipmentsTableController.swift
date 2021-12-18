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

class EquipmentsTableController: UITableViewController {

    /**
     Обновление таблицы
     */
    @objc func refresh(sender: AnyObject){
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let equipments = Application.app.getEquipments()

        var count = equipments.count
        if(count == 0){
            count = 1
        }
        
        return count
    }

    /**
     Cell
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let equipments = Application.app.getEquipments()

        if(equipments.count == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "add", for: indexPath)
            return cell
        }
        
        let equipmentDict = equipments[indexPath.item]

        let cell = tableView.dequeueReusableCell(withIdentifier: "equipment", for: indexPath)
        cell.textLabel?.text = equipmentDict["caption"] as? String
        cell.detailTextLabel?.text = equipmentDict["type"] as? String
        return cell
    }

    /**
     Editable
     */
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let equipments = Application.app.getEquipments()
        return equipments.count > 0
    }

    /**
     Delete equipment
     */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Application.app.removeEquipment(index: indexPath.row)
            self.tableView.reloadData()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - UITableViewDelegate Methods
    
    /**
     Action after select row
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let equipments = Application.app.getEquipments();
        if(equipments.count > 0){
            let row = indexPath.row
            let equipmentDict = equipments[row]
            store.dispatch(CurrentEquipmentAction.select(dict: equipmentDict))
        }
    }
    
    /**
     Height rows
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let equipments = Application.app.getEquipments();

        if(equipments.count == 0){
            return 175
        }
        
        return 43.5
        
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
