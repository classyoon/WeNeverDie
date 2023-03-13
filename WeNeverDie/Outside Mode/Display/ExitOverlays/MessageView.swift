//
//  MessageView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/13/23.
//

import SwiftUI

struct MessageView: View {
    let message : String
    let buttonText : String

    var body: some View {
        VStack{
            Text(message)
                .font(.title).foregroundColor(Color.black)
            Button {
                
            } label: {
                Text(buttonText)
            }.buttonStyle(.borderedProminent)
        }.padding()
            .background(.white)
            .cornerRadius(20)
            .shadow(radius: 10)
    }
}

struct MessagePopup_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "Hi", buttonText: "Bye")
    }
}
