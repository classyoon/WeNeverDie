//
//  StatusViewBar.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/27/23.
//

import SwiftUI

struct StatusViewBar: View {
    @Binding var food : Int
    @ObservedObject var vm : Board
    
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
    var body: some View {
        
            VStack{
                
                Text("Food collected : \(food)")
                VStack(spacing: 30.0){
                    Button {
                        
                        if vm.unitWasSelected{
                            searchLocation()
                            vm.turn = UUID()
                        }
                    } label: {
                        Text("Search")
                    }
                    
                }
                HStack{
                    Rectangle().fill(vm.canAnyoneMove ? Color.red : Color.green ).frame(width: 10, height: 10)
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

struct StatusViewBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusViewBar(food: .constant(10), vm: Board(players: 1))
    }
}
