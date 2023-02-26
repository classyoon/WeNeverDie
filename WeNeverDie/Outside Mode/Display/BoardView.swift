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
        landscapeBoard
    }
    
    var landscapeBoard: some View {
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
                            .frame(maxHeight: .infinity)
                            .padding(.horizontal)
                  
                        }
                    }
                    .id(vm.turn)
                }.overlay{
                    !vm.missionUnderWay ?
                    ExitOverlayView(food: food, gameData: GameData, showBoard: $showBoard, unitsDied: vm.UnitsDied)
                    : nil
                    
                }.padding()
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal)
            .background(Color.white)
            .shadow(radius: 10)
            //                  .overlay(
            //                      statusView
            //                          .frame(width: 500, height: 100)
            //                          .padding(),
            //                      alignment: .bottom
            //                  )
            statusView.frame(width: 200)
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
            //            Text(weaponry ? "Collected enough food for \(food) people" : "")
            Text("Food collected : \(food)")
            //            Group{
            //                if let loc = vm.highlightSquare {
            //                    Text("Coordinate \(loc.row), \(loc.col) Loot \(vm.terrainBoard[loc.row][loc.col].loot) \n \(selectedStats)")
            //                }
            //            }
            //Spacer()
            VStack(spacing: 30.0){
                Button {
                    
                    if vm.unitWasSelected{
                        searchLocation()
                        vm.turn = UUID()
                    }
                } label: {
                    Text("Search")
                }
                //                Button {
                //                    weaponry.toggle()
                //                } label: {
                //                    Text("Inventory")
                //                }
                
            }
            //Spacer()
            HStack{
                Button {
                    withAnimation{vm.nextTurn()}
                    vm.turn = UUID()
                    
                } label: {
                    
                    Text("Next Turn").foregroundColor(Color.white)
                        .padding()
                        .background(.brown)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20))
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(ZStack{Color.orange
            Color.secondary
                .opacity(0.3)
        })
        .cornerRadius(20)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(showBoard: Binding.constant(false), vm: Board(players: 3), GameData: Binding.constant(ResourcePool(surviors: 3, food: 10)))
    }
}
