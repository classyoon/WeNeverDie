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
    @State var selectedStats = ""
    @Binding var showBoard : Bool
    @State var food = 0
    @State var weaponry = true
    @State var talk = true
    @Namespace var nameSpace : Namespace.ID
    @ObservedObject var vm : Board
    @ObservedObject var GameData : ResourcePool
    @State var people = 2
    @ViewBuilder
    func getTileAppearance(row : Int, col : Int)-> some View{
        switch vm.terrainBoard[row][col].name{
        case "h":
            Tile2(image: "building", tileLocation: Coord(row, col))
        case "t":
            ZStack{
                Tile(colored: Color.brown, tileLocation: Coord(row, col))//Forest
                Image("forest").resizable()
            }
        case "w":
            Tile2(image: "water", tileLocation: Coord(row, col))
        case "X":
            ZStack{
                Tile2(image: "grass", tileLocation: Coord(row, col))
                Image("escape").resizable()
                
            }
            
        default:
            Tile2(image: "grass", tileLocation: Coord(row, col))
        }
    }
    func getTileOld(row : Int, col : Int)-> some View{
        switch vm.terrainBoard[row][col].name{
        case "h":
            return Tile(colored: Color.red, tileLocation: Coord(row, col))
            
        case "t":
            return Tile(colored: Color.brown, tileLocation: Coord(row, col))//Forest
            
        case "w":
            return Tile(colored: Color.blue, tileLocation: Coord(row, col))
        case "X":
            return Tile(colored: Color.purple, tileLocation: Coord(row, col))
            
        default:
            return Tile(colored: Color.green, tileLocation: Coord(row, col))
        }
    }
    
    //    @EnvironmentObject var navManager : NavManager
    var body: some View {
        VStack{
            GeometryReader{ geo in
                VStack(spacing: 0){
                    ForEach(0..<vm.rowMax, id: \.self) { row in
                        HStack(spacing: 0){
                            ForEach(0..<vm.colMax, id: \.self) { col in
                                ZStack{
                                    getTileAppearance(row: row, col: col)
                                    Group{
                                        if let loc = vm.highlightSquare, loc.col == col && loc.row == row {
                                            RoundedRectangle(cornerRadius: 30).fill(Color.blue.opacity(0.3)).padding()
                                        }
                                        if vm.isPossibleLoc(row: row, col: col) && vm.unitWasSelected{
                                            Circle().fill(Color.white.opacity(0.3)).padding()
                                        }
                                    }
                                    if let piece = vm.board[row][col] {
                                        pieceDisplay(piece: piece, nameSpace: nameSpace)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation{
                                        vm.handleTap(tapRow: row, tapCol: col)
                                    }
                                    withAnimation(.easeOut.delay(0.75)){
                                        vm.checkEndMission()
                                    }
                                }
                            }
                        }
                    }
                }
                .id(vm.turn)
            }.overlay{
                !vm.missionUnderWay ?
                VStack{
                    Text("End Mission : Gathered \(food) rations, total food for the day should be \(GameData.foodResource-GameData.survivorNumber+food)")
                        .font(.title)
                    Button {
                        showBoard = false
                        GameData.foodResource += food
                        GameData.passDay()
                        print(GameData.survivorNumber)
                        GameData.survivorNumber -= vm.UnitsDied
                        print(GameData.survivorNumber)
                    } label: {
                        Text("Back to Camp")
                    }.buttonStyle(.borderedProminent)
                    
                }.padding()
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                : nil
                
            }.padding()
            statusView
                .frame(height: 200)
                .padding()
        }
        .background(Color.gray)
        
    }
    
    func searchLocation(){
        if var selected = vm.selectedUnit {
            
            if let piece = vm.getCoord(of: selected){ //?? nil
                
                if selected.getCanMove(){
                    print(selected.movementCount)
                    vm.board[piece.row][piece.col]?.movementCount+=1//Upfront stamina cost.
                    selected.movementCount+=1
                    if vm.terrainBoard[piece.row][piece.col].loot>0{
                        food+=1
                        vm.terrainBoard[piece.row][piece.col].loot-=1
                    }
                }
                vm.selectedUnit = selected
            }
        }
        
    }
    
    var statusView: some View {
        VStack{
//            Text("Objective : We're running low on food today in the apocalypse. We are still working on the farms. You should grab enough food to feed yourselves. If you see any red roof houses, you should search them. Hide in the brown if you get overwhelmed by the undead.")
            Text(weaponry ? "Collected enough food for \(food) people" : "")
            Group{
                if let loc = vm.highlightSquare {
                    Text("Coordinate \(loc.row), \(loc.col) Loot \(vm.terrainBoard[loc.row][loc.col].loot) \n \(selectedStats)")
                }
            }
            Spacer()
            HStack(spacing: 30.0){
                Button {
                    if vm.unitWasSelected{
                        searchLocation()
                        vm.turn = UUID()
                    }
                } label: {
                    Text("Search")
                }
                Button {
                    weaponry.toggle()
                } label: {
                    Text("Inventory")
                }
                
            }
            Spacer()
            HStack{
                Button {
                    withAnimation{vm.nextTurn()}
                    vm.turn = UUID()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 100, height: 50).foregroundColor(Color.brown)
                        Text("Next Turn").foregroundColor(Color.white)
                    }.padding()
                }
            }
        }
        .background(Color.yellow)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(showBoard: Binding.constant(true), vm: Board(players: 3), GameData: ResourcePool(surviors: 3, food: 10))
    }
}
