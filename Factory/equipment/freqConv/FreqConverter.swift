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
class FreqConverter: EquipmentDevice{
    
    private var _equipment: EquipmentDict
    private var _freq: Int = 0
    
    static let OBJ_NAME_DEVICE = 0x50
    static let OBJ_NAME_ENGINE = 0x51
    static let OBJ_NAME_FREQ = 0x52
    static let OBJ_NAME_DIRECTION = 0x53
    
    static let CMD_READ = 0x01
    static let CMD_WRITE = 0x02
    
    static let ENGINE_STATE_RUN = 0x01
    static let ENGINE_STATE_STOP = 0x02

    
    init(equipment: EquipmentDict){
        
        _equipment = equipment
        _freq = 0
        
    }
    
    /**
     Запустить двигатель
     */
    func engineStart(){
        
        let data = [FreqConverter.OBJ_NAME_ENGINE, FreqConverter.CMD_WRITE, FreqConverter.ENGINE_STATE_RUN]
        
    }
    
    /**
     Остановить двигатель
     */
    func engineStop(){
        
        let data = [FreqConverter.OBJ_NAME_ENGINE, FreqConverter.CMD_WRITE, FreqConverter.ENGINE_STATE_STOP]

    }
    
    /**
     Установить частоту вращения
     */
    func setFreq(value: Int){
        
        let data = [FreqConverter.OBJ_NAME_FREQ, FreqConverter.CMD_WRITE, (value >> 8) & 0xFF, (value) & 0xFF]
        
    }
    
    
}
