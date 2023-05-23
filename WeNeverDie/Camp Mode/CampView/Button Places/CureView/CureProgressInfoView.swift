//
//  CureProgressInfoView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct CureProgressInfoView: View {
    @Binding var showCure : Bool
    var buildingMan : BuildingManager
    @State var stock : Stockpile
    var vm = BuildingsViewModel()
    var progress = 0
    var max = 0
   
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(.secondarySystemBackground))
            .frame(width: 300, height: 200)
            .overlay(
                VStack{
                    Text("Workers \(stock.getNumOfPeople()), Materials \(stock.getNumOfMat())").padding()
                    ScrollView{
                        ForEach(buildingMan.buildings.indices, id: \.self) { index in
                            BuildingView(building: buildingMan.buildings[index], vm: vm, buildMan: buildingMan, stock: stock)
                            Text("Hi")
                            
                        }
                    }
                    .foregroundColor(.black)
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
//struct WrapperCureProgression : View {
//    @State var cureProgression = 5
//    @State var cureCondition = 10
//    var body: some View{
//        CureProgressInfoView(progress: cureProgression, max: cureCondition, showCure: .constant(true))
//    }
//}
struct CureProgressInfo_Previews: PreviewProvider {
    static var previews: some View {
        CureProgressView(gameData: ResourcePool(), uiSettings: UserSettingsManager(), showCureHelp: .constant(true), vm: BuildingsViewModel())
    }
}
