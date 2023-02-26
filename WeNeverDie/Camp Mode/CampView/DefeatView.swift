//
//  DefeatView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct DefeatView : View {
    @State var GameData : ResourcePool
    var body: some View {
        
        VStack{
            Text("Dead")
                .font(.title).foregroundColor(Color.black)
                .colorScheme(.dark)
            Button("Exit to reset"){
                GameData.ResetGame = true
                
            }
        }.padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
    
}

struct DefeatView_Previews: PreviewProvider {
    static var previews: some View {
        DefeatView(GameData: ResourcePool(surviors: 0, food: 0))
    }
}
