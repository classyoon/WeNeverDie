//
//  InfoView.swift
//  NameSelectionTest
//
//  Created by Conner Yoon on 6/11/23.
//

import SwiftUI

struct InfoView: View {
    @Binding var flagBool : Bool
    @State var infoText : String = "Text"
    @State var buttonText : String = "Text"
    var body: some View {
        VStack{
            ScrollView{
                Text(infoText)
            }
                .frame(width: 250, height: 200)
            Button(buttonText){
               flagBool = false
            }.buttonStyle(.bordered)
        }.background(RoundedRectangle(cornerRadius: 20)
            .fill(.thickMaterial)
            .frame(width: 300, height: 300))
       
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(flagBool: .constant(true))
    }
}
