/*
amikodev/factory-ios - Industrial equipment management with iOS mobile application
Copyright © 2021-2022 Prihodko Dmitriy - asketcnc@yandex.ru
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
import SideMenu
import Combine

class FreqConverterMainController: UIEquipmentDeviceViewController {

    @IBOutlet weak var FreqText: UITextField!
    @IBOutlet weak var FreqSlider: UISlider!
    
    private var _equipmentDevice: IFreqConverter?
    var wifiEquipment: IWifiEquipment?

    
    private var stream: AnyCancellable?

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // start listeners

        stream = store.$state.sink {state in
            let equipmentDict: EquipmentDict = state.currentEquipmentDict.equipmentDict
            if(!equipmentDict.isEmpty){
                if(state.currentEquipmentDict.isSelected){
                    let eq: IEquipmentDevice = FreqConverter(equipment: equipmentDict)
                    self._equipmentDevice = eq as! IFreqConverter
                    self.wifiEquipment = WifiEquipment(connection: eq._connection)
                    self.connectionListenStart(connection: eq._connection)
                    eq._connection?.connect()
                }
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // stop listeners
        
        stream?.cancel()
        
    }
    
    

    @IBAction func StartEngineClick(_ sender: UIButton) {
        
        print("start engine")
        
        _equipmentDevice?.engineStart()
        
    }
    
    
    @IBAction func StopEngineClick(_ sender: UIButton) {
        
        print("stop engine")
        
        _equipmentDevice?.engineStop()
        
    }
    
    
    @IBAction func FreqButtonClick(_ sender: UIButton) {
        let freq: Int = (sender.titleLabel?.text as? NSString)?.integerValue ?? 0
        FreqSlider.value = Float(freq)
        
        _equipmentDevice?.setFreq(value: freq)
        
        FreqText.text = String(freq)
    }
    @IBAction func FreqSliderChange(_ sender: UISlider) {
        let freq: Int = Int(sender.value)
        
        FreqText.text = String(freq)
        FreqText.backgroundColor = .systemBrown
    }
    
    @IBAction func FreqSliderChangeEnd(_ sender: UISlider) {
        let freq: Int = Int(sender.value)
        
        FreqText.backgroundColor = .clear
        
        _equipmentDevice?.setFreq(value: freq)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.destination.children[0] is IUIWifiForm){
            var wf: IUIWifiForm = segue.destination.children[0] as! IUIWifiForm
            wf.wifiEquipment = wifiEquipment
        }
        
    }

}
