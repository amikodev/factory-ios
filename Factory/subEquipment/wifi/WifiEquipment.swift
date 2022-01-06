/*
amikodev/factory-ios - Industrial equipment management with iOS mobile application
Copyright © 2022 Prihodko Dmitriy - asketcnc@yandex.ru
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
 Wifi
 */
class WifiEquipment: WsDefaultProtocol, IWifiEquipment{
    

    static let WS_OBJ_NAME_WIFI: UInt8 = 0x20

    static let WS_WIFI_SETTINGS: UInt8 = 0x01
    static let WS_WIFI_SCAN: UInt8 = 0x02

    static let WS_WIFI_MODE_STA: UInt8 = 0x01
    static let WS_WIFI_MODE_AP: UInt8 = 0x02


    func readSettings(){
        typealias WSE = WifiEquipment

        send(data: [WSE.WS_OBJ_NAME_WIFI, WSE.WS_WIFI_SETTINGS, WS_CMD_READ])

    }
    
    func writeSettings(wifiMode: String, wifiSsid: String, wifiPassword: String){
        typealias WSE = WifiEquipment

        var mode: UInt8 = 0x00;
        if(wifiMode == "STA"){ mode = WSE.WS_WIFI_MODE_STA }
        else if(wifiMode == "AP"){ mode = WSE.WS_WIFI_MODE_AP }

        var arr: [UInt8] = prepareData(preData: [WSE.WS_OBJ_NAME_WIFI, WSE.WS_WIFI_SETTINGS, WS_CMD_WRITE, mode])

        arr += prepareData(text: wifiSsid, count: 32)
        arr += prepareData(text: wifiPassword, count: 64)

        sendRaw(data: arr)

    }
    
}

protocol IWifiEquipment: ISubEquipmentDevice{

    func readSettings()
    func writeSettings(wifiMode: String, wifiSsid: String, wifiPassword: String)
    
}


