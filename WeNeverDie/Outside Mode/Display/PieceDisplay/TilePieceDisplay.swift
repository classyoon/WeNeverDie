//
//  TilePieceDisplay.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI

struct TilePieceDisplay: View {
    @ObservedObject var gameData : ResourcePool
    
  
    @ViewBuilder
    func getTileAppearance(row : Int, col : Int)-> some View{
        switch vm.terrainBoard[row][col].name{
        case "h":
            Tile2(image: "building", tileLocation: Coord(row, col))
        case "t":
            Tile2(image: "forest", tileLocation: Coord(row, col), optionalColor: Color.brown)
        case "w":
            Tile2(image: "water", tileLocation: Coord(row, col))
        case "X":
            Tile2(image: "grass", tileLocation: Coord(row, col), image2: "escape")
        default:
            Tile2(image: "grass", tileLocation: Coord(row, col))
        }
    }
    let row, col : Int
    @ObservedObject var vm : Board
    //    let nameSpace : Namespace
    var body: some View {
        ZStack {
            getTileAppearance(row: row, col: col)
            Group {
                if let loc = vm.highlightSquare, loc.col == col && loc.row == row {
                    RoundedRectangle(cornerRadius: 30).fill(Color.blue.opacity(0.3)).padding()
                }
                if vm.isPossibleLoc(row: row, col: col) && vm.unitWasSelected {
                    Circle().fill(Color.white.opacity(0.3)).padding()
                }
                if vm.isPossibleLoc(row: row, col: col) && vm.unitWasSelected {
                    if let piece = vm.board[row][col] {
                        if piece.team == .zombieUnit {
                            Circle().fill(Color.red.opacity(0.5)).padding()
                        }
                        if piece.team == .recruitableUnit {
                            Circle().fill(Color.green.opacity(0.5)).padding()
                        }
                    }
                }
            }
            if let piece = vm.board[row][col] {
                PieceDisplay(gameData: gameData, piece: piece)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onTapGesture {
            withAnimation {
                vm.handleTap(tapRow: row, tapCol: col)
            }
            withAnimation(.easeOut.delay(1)) {
                vm.checkEndMission()
            }
        }
    }
}

struct TilePieceDisplay_Previews: PreviewProvider {
    static var previews: some View {
        TilePieceDisplay(gameData: ResourcePool(), row: 10, col: 10, vm: Board())
    }
}
