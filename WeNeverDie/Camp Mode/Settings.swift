//
//  Settings.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/23/23.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var gameData : ResourcePool
    var body: some View {
        VStack{
//            Toggle(isOn: musicPlayer?.stop()) {
//                "Music"
            Button("Reset"){
                gameData.reset()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(gameData: ResourcePool(surviors: 1, food: 10))
    }
}
