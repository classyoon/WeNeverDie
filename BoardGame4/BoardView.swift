//
//  BoardView.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var vm = Board()
    @State var showStats = false
    var body: some View {
        VStack{
            GeometryReader{ geo in
                VStack(spacing: 0){
                    ForEach(0..<vm.rowMax, id: \.self) { row in
                        HStack(spacing: 0){
                            ForEach(0..<vm.colMax, id: \.self) { col in
                                ZStack{
                                    Tile(size: 25.0, colored: Color.green, difference: 0.15, isSelected: false, tileLocation: Loc(row: row, col: col))
                                    
                                    if let piece = vm.board[row][col] {
                                        VStack{
                                            piece.getView()
                                            if showStats {
                                                Text(showStats ? (("\(piece.health) \(piece.stamina-piece.movementCount)"))).padding()
                                            }
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
            HStack{
                statusView
                Button {
                    showStats.toggle()
                } label: {
                    ZStack{
                        Rectangle().frame(width: 100, height: 50)
                        Text("Show Vitals").foregroundColor(Color.black)
                    }
                }
            }
                .frame(height: 300)
        }
    }
    var statusView: some View {
        VStack{
            Text("Objective : ")
//            Text("Is Tapped: \(vm.isTapped.description)")
            Spacer()
            HStack(spacing: 30.0){
                Button {
                    
                } label: {
                    Text("Search")
                }
                Button {
                    
                } label: {
                    Text("Attack")
                }
                Button {
                    
                } label: {
                    Text("Inventory")
                }
                Button {
                    
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
