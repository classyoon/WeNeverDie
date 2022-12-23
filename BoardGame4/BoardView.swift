//
//  BoardView.swift
//  BoardGame
//
//  Created by Tim Yoon on 11/27/22.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var vm = Board()
    
    var body: some View {
        VStack{
            GeometryReader{ geo in
                VStack(spacing: 0){
                    ForEach(0..<vm.rowMax, id: \.self) { row in
                        HStack(spacing: 0){
                            ForEach(0..<vm.colMax, id: \.self) { col in
                                Group{
                                    
                                    if let piece = vm.board[col][row] {
                                        piece.getView()
                                            .frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))
                                    }else{
                                        Tile(size: 25.0, colored: Color.green, difference: 0.15, isSelected: false, tileLocation: Loc(row: row, col: col))
                                        
                                    }
                                }
                                .onTapGesture {
                                    vm.handleTap(row: row, col: col)
                                }
                                //                                .padding(4)
                                .background(
                                    Group{
                                        
                                        if let loc = vm.tappedLoc, loc.row == row && loc.col == col {
                                            RoundedRectangle(cornerRadius: 10).fill(Color.green.opacity(0.8))
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
            }
            //            .padding()
            statusView
                .frame(height: 100)
        }
    }
    var statusView: some View {
        VStack{
            Text("Is Tapped: \(vm.isTapped.description)")
            
            Group{
                if let loc = vm.tappedLoc {
                    Text("\(loc.row), \(loc.col)")
                    Text("Selected : \(vm.findStats())")//
                }
            }
            HStack{
                Button {
                    vm.nextTurn()
                } label: {
                    ZStack{
                        Rectangle().frame(width: 100, height: 50)
                        Text("Next Turn").foregroundColor(Color.black)
                    }
                }
                
            }
            //            ForEach(vm.possibleLoc, id: \.self) { location in
            //                Text("Possible: \(location.row), \(location.col)")
            //            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
