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
                    vm.board[piece.row][piece.col]?.movementCount+=1//Upfront stamina cost.
                    selected.movementCount+=1
                    if vm.terrainBoard[piece.row][piece.col].loot>0{
                        food+=1
                        vm.terrainBoard[piece.row][piece.col].loot-=1
                        grabSoundPlayer?.prepareToPlay()
                        grabSoundPlayer?.play()
                    }
                    else {
                        emptySoundPlayer?.prepareToPlay()
                        emptySoundPlayer?.play()
                    }
                }
                vm.selectedUnit = selected
            }
        }
        
    }
    var body: some View {
        VStack{
            Text(vm.changeToNight ? "It's night" : "\(vm.turnsOfDaylight-vm.turnsSinceStart) hrs til night").foregroundColor(vm.changeToNight ? Color.red : nil)
            Text("Food collected : \(food)")
                .foregroundColor(vm.changeToNight ? .white : .black)
            VStack(spacing: 30.0){
                Button {
                    
                    if vm.unitWasSelected{
                        searchLocation()
                        vm.canAnyoneMove = vm.isAnyoneStillActive()
                        vm.turn = UUID()
                        if !(vm.selectedUnit?.getCanMove() ?? true) {
                            vm.deselectUnit()
                        }
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
                .opacity(!vm.changeToNight ? 0.1 : 2)
        })
        .cornerRadius(20)
        
        
    }
}

struct StatusViewBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusViewBar(food: .constant(10), vm: Board())
    }
}
