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
                    ExitOverlayView(food: food, gameData: GameData, showBoard: $showBoard, unitsDied: vm.UnitsDied)
                    : nil
                    
                }
            StatusViewBar(food: $food, vm: vm)
        }.background(Color.black)
    }
    
    
    var boardView: some View {
        HStack(spacing: 0) {
            
            Spacer()
            GeometryReader { geo in
                ScrollView{
                    VStack(spacing: 0) {
                        ForEach(0..<vm.rowMax, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<vm.colMax, id: \.self) { col in
                                    TilePieceDisplay(row: row, col: col, vm: vm)
                                }
                            }
                        }
                    }
                    .id(vm.turn)
                }
            }
            StatusViewBar(food : $food, vm : vm).frame(width: 200)
        }
        .background(Color.black)
        
        
    }
}

struct OutsideView_Previews: PreviewProvider {
    static var previews: some View {
        OutsideView(showBoard: Binding.constant(false), vm: Board(players: 3), GameData: Binding.constant(ResourcePool(surviors: 3, food: 10)))
    }
}
