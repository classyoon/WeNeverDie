//
//  CountDown.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/20/23.
//

import SwiftUI

struct CountDown: View {
    @ObservedObject var vm : Board
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        Text(vm.changeToNight ? "It's night" : "\(vm.turnsOfDaylight-vm.turnsSinceStart) hrs til night").foregroundColor(vm.changeToNight ? (gameData.visionAssist ? Color.yellow : Color.red) : nil)
        
    }
   
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDown(vm: Board(), gameData: ResourcePool())
    }
}
