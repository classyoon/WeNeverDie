//
//  DefaultStatDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/22/23.
//

import SwiftUI

struct DefaultStatDisplay: View {
    @ObservedObject var uiSetting : UserSettingsManager
    @State var piece : any Piece
    var body: some View {
        VStack{
            HStack{
                
                (!piece.isRecruitable ? Text("\(piece.health)") : nil)
                    .padding(2)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(10)
                Spacer()
                
            }.padding(0.5)
            Spacer()
            !piece.isRecruitable ? staminaBars(uiSettings: uiSetting, piece: piece) : nil
            !piece.isRecruitable ?  nil : Text("Trust : \(piece.trust)").padding(2)
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(10)
        }
    }
}

struct DefaultStatDisplay_Previews: PreviewProvider {
    static var previews: some View {
        DefaultStatDisplay(uiSetting: UserSettingsManager(), piece: Zombie(board: Board()))
    }
}
