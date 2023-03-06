//
//  OutsideView.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//
import AVFoundation
import SwiftUI
var soundPlayer: AVAudioPlayer!


struct OutsideView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    @State var selectedStats = ""
    @Binding var showBoard : Bool
    @State var food = 0
    @State var weaponry = true
    @State var talk = true
    
    //    @Namespace var nameSpace : Namespace.ID
    @ObservedObject var vm : Board
    @Binding var GameData : ResourcePool
    @State var people = 2
    
    
    var body: some View {
        HStack{
            BoardView(vm: vm)
                .overlay{
                    !vm.missionUnderWay ?
                    ExitOverlayView(food: food, gameData: GameData, showBoard: $showBoard, unitsDied: vm.UnitsDied, unitsRecruited: vm.UnitsRecruited)
                    : nil
                    
                }
            StatusViewBar(food: $food, vm: vm)
        }.background(Color.black)
    }
    
}

struct OutsideView_Previews: PreviewProvider {
    static var previews: some View {
        OutsideView(showBoard: Binding.constant(false), vm: Board(players: 3), GameData: Binding.constant(ResourcePool(surviors: 3, food: 10)))
    }
}
