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
                Text(vm.changeToNight ? "\(vm.turnsOfDaylight) hours left before dawn" : "\(vm.turnsOfDaylight) hours left before nightfall").foregroundColor(vm.changeToNight ? Color.red : nil)
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
                    .foregroundColor(vm.canAnyoneMove ? .white : .red)
                    .buttonStyle(.borderedProminent)
                    
                    
                }
                HStack{
                    Button {
                        withAnimation{vm.nextTurn()}
                        vm.turn = UUID()
                        
                    } label: {
                        
                        Text("Next Turn").foregroundColor(Color.white)
                        
                            .padding()
                            .background(vm.canAnyoneMove ? .gray : .green)
                            
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20))
                    }
                    .buttonStyle(.plain)
                    .shadow(color: vm.canAnyoneMove ? .clear : .green, radius: 5)
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
