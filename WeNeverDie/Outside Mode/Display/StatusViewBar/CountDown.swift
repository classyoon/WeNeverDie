//
//  CountDown.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct CountDown: View {
    @ObservedObject var vm : Board
    @ObservedObject var uiSettings : UserSettingsManager
    var body: some View {
        Text(vm.changeToNight ? "It's night" : "\(vm.turnsOfDaylight-vm.turnsSinceStart) turns til night").foregroundColor(vm.changeToNight ? (uiSettings.visionAssist ? Color.yellow : Color.red) : nil)
        
    }
   
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDown(vm: Board(), uiSettings: UserSettingsManager())
    }
}
