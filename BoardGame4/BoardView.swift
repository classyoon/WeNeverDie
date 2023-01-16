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
    @ViewBuilder
    func getTile(row : Int, col : Int)-> some View{
        if vm.checkForTree(row, col){
            
            Tile(size: 100, colored: Color.brown, tileLocation: Coord(row, col))
        }
        else if vm.checkForLoot(row, col){
            Tile(size: 100, colored: Color.red, tileLocation: Coord(row, col))
        }
        else{
            Tile(size: 100, colored: Color.green, tileLocation: Coord(row, col))
        }
    }
    func searchLocation(){
     
        guard vm.getCoord(of: vm.selectedUnit!) != nil else {return}
        
        let piece = vm.getCoord(of: vm.selectedUnit!)
        
        if vm.selectedUnit!.getCanMove(){
            if vm.lootBoard[piece!.row][piece!.col]>0{
                food+=1
                vm.lootBoard[piece!.row][piece!.col]-=1
//                vm.selectedUnit!.movementCount+=1
                vm.board[piece!.row][piece!.col]?.movementCount+=1
                print("Search 1 \(String(describing: vm.selectedUnit?.movementCount))")
                
            }
            else{
//                vm.selectedUnit!.movementCount+=1
                vm.board[piece!.row][piece!.col]?.movementCount+=1
                print("Search 2 \(String(describing: vm.board[piece!.row][piece!.col]?.movementCount))")
                
            }
        }
    }
    
    var body: some View {
        VStack{
            GeometryReader{ geo in
                VStack(spacing: 0){
                    ForEach(0..<vm.rowMax, id: \.self) { row in
                        HStack(spacing: 0){
                            ForEach(0..<vm.colMax, id: \.self) { col in
                                ZStack{
                                    
                                    //                                    Tile(size: 25.0, colored: Color.green , difference: 0.25, isSelected: false, tileLocation: Coord(row: row, col: col)).if(vm.checkForTree(row, col)) { view in
                                    //                                        ZStack{
                                    //                                            Tile(size: 25.0, colored: Color.brown, difference: 0.25, isSelected: false, tileLocation: Coord(row: row, col: col))
                                    //                                        }
                                    //                                    }
                                    getTile(row: row, col: col)
                                    
                                    
                                    if let piece = vm.board[row][col] {
                                        VStack{
                                            piece.getView()
                                            Text("H \(piece.health) S \(piece.stamina-piece.movementCount)")//.padding()
                                            Spacer()
                                        }.frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))
                                    }
                                    
                                    
                                }
                                .onTapGesture {vm.handleTap(row: row, col: col)}
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
                                //.frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))
                            }
                        }
                    }
                }
            }//.background(in: Color.green)
            //            .padding()
            statusView
                .frame(height: 200)
        }
    }
    
    
    var statusView: some View {
        VStack{
            Text("Objective : We found a group of zombies near our pastures. We can't spare anyone else, go clear them out and then come back to camp. It shouldn't be too difficult.\n\nJournal Log : The cows are all dead. It was an ambush.")
            //            Text("Is Tapped: \(vm.isTapped.description)")
            Text(weaponry ? "" : "Axe 5 Damage, Food \(food)")
            Text(talk ? "" : "Nobody to talk to")
            Group{
                if let loc = vm.tappedLoc {
                    Text("Coordinate \(loc.row), \(loc.col)")
                }
            }
            Spacer()
            HStack(spacing: 30.0){
                Button {
                    
                    searchLocation()
                    if vm.getCoord(of: vm.selectedUnit!) != nil {
                        print(vm.selectedUnit?.getCanMove() ?? "There is none")
                        print(vm.selectedUnit?.movementCount ??  "There is none")
                    }
                    else{
                        print(vm.selectedUnit?.getCanMove() ?? "There is none")
                        print(vm.selectedUnit?.movementCount ??  "There is none")
                    }
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
                        RoundedRectangle(cornerRadius: 20).frame(width: 100, height: 50).foregroundColor(Color.brown)
                        Text("Next Turn").foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(vm: Board())
    }
}
