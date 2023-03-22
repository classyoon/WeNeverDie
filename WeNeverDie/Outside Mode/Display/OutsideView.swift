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
    
    
    var body: some View {
        NavigationStack {
            HStack{
                gameData.switchToLeft ? StatusViewBar(vm: vm, gameData: gameData) : nil
                
                BoardView(gameData : gameData, vm: vm)
                    .overlay{
                        (!vm.missionUnderWay && !vm.showEscapeOption) ?
                        ExitOverlayView(vm: vm, gameData: gameData, showBoard: $showBoard, unitsDied: vm.UnitsDied, unitsRecruited: vm.UnitsRecruited)
                        : nil
                        
                    }
                    .overlay{
                        vm.showEscapeOption ?
                        Group{
                            NightDecisionView(resultCalculator: NightResultCalculator(zombieCount: vm.numberOfZombies), showBoard: $showBoard, vm: vm, gameData: gameData)
                        }
                        : nil
                    }
                
                gameData.switchToLeft ? nil :
                StatusViewBar(vm: vm, gameData: gameData)
            }.background(Color.black)
        }
    }
}

struct OutsideView_Previews: PreviewProvider {
    static var previews: some View {
        OutsideView(showBoard: Binding.constant(false), vm: Board(), gameData: ResourcePool())
    }
}
