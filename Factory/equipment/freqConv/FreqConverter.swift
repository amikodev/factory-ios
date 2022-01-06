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
 Частотный преобразователь
 */
class FreqConverter: WsDefaultProtocol, IFreqConverter{
    
    
    private var _equipment: EquipmentDict
    var _freq: Int = 0
    
    static let OBJ_NAME_ENGINE: UInt8 = 0x51
    static let OBJ_NAME_FREQ: UInt8 = 0x52
    static let OBJ_NAME_DIRECTION: UInt8 = 0x53
    
    static let ENGINE_STATE_RUN: UInt8 = 0x01
    static let ENGINE_STATE_STOP: UInt8 = 0x02

    
    init(equipment: EquipmentDict){
        
        _equipment = equipment
        _freq = 0
        
        super.init(url: _equipment["url"] as! String)
        
    }
    
    /**
     Запустить двигатель
     */
    func engineStart(){
        typealias FC = FreqConverter
        send(data: [FC.OBJ_NAME_ENGINE, WS_CMD_WRITE, FC.ENGINE_STATE_RUN])
    }
    
    /**
     Остановить двигатель
     */
    func engineStop(){
        typealias FC = FreqConverter
        send(data: [FC.OBJ_NAME_ENGINE, WS_CMD_WRITE, FC.ENGINE_STATE_STOP])
    }
    
    /**
     Установить частоту вращения
     */
    func setFreq(value: Int){
        typealias FC = FreqConverter
        let val = value * 10
        send(data: [FC.OBJ_NAME_FREQ, WS_CMD_WRITE, UInt8((val >> 8) & 0xFF), UInt8((val) & 0xFF)])
    }
    
}


protocol IFreqConverter: IEquipmentDevice{
    
    // частота вращения
    var _freq: Int { get set }
    
    /**
     Запустить двигатель
     */
    func engineStart()
    
    /**
     Остановить двигатель
     */
    func engineStop()

    /**
     Установить частоту вращения
     */
    func setFreq(value: Int)

}
