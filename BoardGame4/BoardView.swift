//
//  BoardView.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//
import AVFoundation
import SwiftUI
var soundPlayer: AVAudioPlayer!

struct BoardView: View {
    @State var food = 0
    @State var weaponry = true
    @State var talk = true
    @ObservedObject var vm = Board()
//    func playSound() {
//        let url = Bundle.main.url(forResource: "POW", withExtension: "mp3")
//        soundPlayer = try! AVAudioPlayer(contentsOf: Sounds )
//        soundPlayer.play()
//    }
    var treeCoords = [ ]
    
    var body: some View {
        VStack{
            GeometryReader{ geo in
                VStack(spacing: 0){
                    ForEach(0..<vm.rowMax, id: \.self) { row in
                        HStack(spacing: 0){
                            ForEach(0..<vm.colMax, id: \.self) { col in
                                ZStack{
//                                    if vm.checkForTree(row, col){
//                                        Rectangle()
//                                    }
                                    Tile(size: 25.0, colored: Color.green , difference: 0.25, isSelected: false, tileLocation: Loc(row: row, col: col))
                                    
                                    if let piece = vm.board[row][col] {
                                        VStack{
                                            piece.getView()
                                            Text("H \(piece.health) S \(piece.stamina-piece.movementCount)")//.padding()
                                                
//                                              piece.getStats()
                                        }.frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))
                                    }
                                    
                                }
                                .onTapGesture {
                                    vm.handleTap(row: row, col: col)
                                }
//
                                .background(
                                    Group{
                                        
                                        if let loc = vm.tappedLoc, loc.col == col && loc.row == row {
                                            RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.8))
                                        }
                                        if vm.isPossibleLoc(row: row, col: col) {
                                            RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.8))
                                        }
                                    }
                                )
                                .frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))
                            }
                        }
                    }
                }
            }//.background(in: Color.green)
            //            .padding()
            statusView
                .frame(height: 300)
        }
    }
    var statusView: some View {
        VStack{
            Text("Objective : We found a group of zombies near our pastures. We can't spare anyone else, go clear them out and then come back to camp. It shouldn't be too difficult.\n \nJournal Log : The cows are all dead. It was an ambush.")
//            Text("Is Tapped: \(vm.isTapped.description)")
            Text(weaponry ? "" : "Axe 5 Damage, Food \(food)")
            Text(talk ? "" : "Nobody to talk to")
            Spacer()
            HStack(spacing: 30.0){
                Button {
                    food+=1
                } label: {
                    Text("Search")
                }
                Button {
                    weaponry.toggle()
                } label: {
                    Text("Inventory")
                }
                Button {
                    talk.toggle()
                } label: {
                    ZStack{
                        Text("Talk")
                    
                    }
                }
            }
Spacer()
            HStack{
                Button {
                    vm.nextTurn()
                } label: {
                    ZStack{
                        Rectangle().frame(width: 100, height: 50)
                        Text("Next Turn").foregroundColor(Color.black)
                    }
                }
                
                Group{
                    if let loc = vm.tappedLoc {
                        Text("\(loc.row), \(loc.col)")
                    }
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
