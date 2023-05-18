//
//  CureProgressInfoView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct CureProgressInfoView: View {
    @Binding var progress : Int
    @State var max : Int
    @Binding var showCure : Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(.secondarySystemBackground))
            .frame(width: 300, height: 200)
            .overlay(
                VStack{
                    Text("Cure Progress : \(progressString)")
                        .font(.title3)
                        .bold()
                        .padding(.bottom)
        
                    Text("Keep survivors at home to progress faster").padding(.bottom)
                    
                    Button("Understood"){
                        showCure = false
                    }.buttonStyle(.bordered)
                }.padding()
            )

        
    }
    private var progressString : String {
        let result = Double(progress)/Double(max)*100
        return String(format: "%.1f%%", result)
    }
}
struct WrapperCureProgression : View {
    @State var cureProgression = 5
    @State var cureCondition = 10
    var body: some View{
        CureProgressInfoView(progress: $cureProgression, max: cureCondition, showCure: .constant(true)).padding()
    }
}
struct CureProgressInfo_Previews: PreviewProvider {
    static var previews: some View {
        WrapperCureProgression()
    }
}
