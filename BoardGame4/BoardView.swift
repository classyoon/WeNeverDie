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
    @Binding var showBoard : Bool
    @State var food = 0
    @State var weaponry = true
    @State var talk = true
    @Namespace var nameSpace : Namespace.ID
    @ObservedObject var vm : Board
    
    @ViewBuilder
    func getTile(row : Int, col : Int)-> some View{
        switch vm.terrainBoard[row][col].name{
        case "h":
            Image("building").resizable()

        case "t":
            ZStack{
                Tile(size: 100, colored: Color.brown, tileLocation: Coord(row, col))//Forest
                Image("forest").resizable()
            }
        case "w":
            Image("water").resizable()
        case "X":
            ZStack{
                Image("grass").resizable()
                Image("escape").resizable()
               
            }
            
        default:
            Image("grass").resizable()
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
                                    getTile(row: row, col: col)
                                    if let piece = vm.board[row][col] {
                                        pieceDisplay(piece: piece, nameSpace: nameSpace)
                                            .frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))//
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
                                .background(
                                    Group{
                                        if let loc = vm.wasTappedCoord, loc.col == col && loc.row == row {
                                            RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.8))
                                        }
                                        if vm.isPossibleLoc(row: row, col: col) && vm.unitWasSelected{
                                            RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.8))
                                        }
                                    }
                                )
                                .frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))
                            }
                        }
                    }
                }
                .id(vm.turn)
            }.overlay{
                !vm.missionUnderWay ?
                VStack{
                    Text("End Mission")
                        .font(.title)
                    Button {
                        showBoard = false
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
            Text("Objective : We're running low on food today in the apocalypse. We are still working on the farms. You should grab enough food to feed yourselves. If you see any red roof houses, you should search them. Hide in the brown if you get overwhelmed by the undead.")
            Text(weaponry ? "Collected enough food for \(food) people" : "")
            Group{
                if let loc = vm.wasTappedCoord {
                    Text("Coordinate \(loc.row), \(loc.col) Loot \(vm.terrainBoard[loc.row][loc.col].loot)")
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
        BoardView(showBoard: Binding.constant(true), vm: Board())
    }
}
