//
//  CureProgressInfoView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct CureProgressInfoView: View {
    @Binding var showCure : Bool
    @ObservedObject var buildMan = BuildingManager.shared
    @ObservedObject var stock = Stockpile.shared
    var progress = 0
    var max = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(.secondarySystemBackground))
        //.frame(width: 400, height: 200)
            .frame(height: 200)
            .overlay(
                VStack{
                    
                    //                    Text("Workers \(Stockpile.shared.getNumOfPeople()-Stockpile.shared.getSurvivorSent()), Materials \(Stockpile.shared.getNumOfMat())").padding()
                    ScrollView{
                        VStack{
                            ForEach(BuildingManager.shared.buildings.indices, id: \.self) { index in
                                if BuildingManager.shared.buildings[index].isActive {
                                    BuildingView(building: BuildingManager.shared.buildings[index], stock: stock).padding(1)
                                    
                                }
                                //.frame(width: 500)
                                
                            }
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
    var game = ResourcePool()
    static var previews: some View {
        VStack{
            CureProgressInfoView(showCure: .constant(true))
            //CureProgressView(gameData: ResourcePool(), uiSettings: UserSettingsManager(), showCureHelp: .constant(true), vm: BuildingsViewModel())
            
        }
    }
}
