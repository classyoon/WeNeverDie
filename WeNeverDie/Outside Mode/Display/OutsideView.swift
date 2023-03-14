//
//  OutsideView.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//
import AVFoundation
import SwiftUI


struct OutsideView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    @State var selectedStats = ""
    @Binding var showBoard : Bool
    @State var food = 0
    @State var weaponry = true
    @State var talk = true
    
    //    @Namespace var nameSpace : Namespace.ID
    @ObservedObject var vm : Board
    @ObservedObject var gameData : ResourcePool
    @State var people = 2
    
    
    var body: some View {
        NavigationStack {
            HStack{
                BoardView(gameData : gameData, vm: vm)
                    .overlay{
                        vm.showEscapeOption ?
                        ExitOverlayView(vm: vm, food: food, gameData: gameData, showBoard: $showBoard, unitsDied: vm.UnitsDied, unitsRecruited: vm.UnitsRecruited)
                        : nil
                        
                    }
                    .overlay{
                        !vm.missionUnderWay ?
                        Group{
                                VStack{
                                    Text("Message to the user:")
                                    HStack{
                                        Button(action: {
                                            
                                            vm.showEscapeOption = true
                                            vm.missionUnderWay = false
                                        }, label: {
                                            Text("Drop food")
                                        })
                                        .buttonStyle(.bordered)
                                        Button(action: {
                                            vm.showEscapeOption = true
                                            vm.missionUnderWay = false
                                        }, label: {
                                            Text("Run")
                                        })
                                        .buttonStyle(.bordered)
                                    }
                                }
                                .frame(width: 300, height: 300)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.thickMaterial)
                                )
                        }
                        : nil
                    }
                
                StatusViewBar(food: $food, vm: vm, gameData: gameData)
            }.background(Color.black)
        }
    }
}

struct OutsideView_Previews: PreviewProvider {
    static var previews: some View {
        OutsideView(showBoard: Binding.constant(false), vm: Board(), gameData: ResourcePool())
    }
}
