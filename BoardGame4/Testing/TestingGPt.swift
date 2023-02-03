//
//  TestingGPt.swift
//  BoardGame4
//
//  Created by Conner Yoon on 2/1/23.
//

import SwiftUI
struct TestingGPt: View {
    @State var food = 0
    @State var weaponry = true
    @Namespace var nameSpace : Namespace.ID
    @State var talk = true
    @ObservedObject var vm : Board
    @ViewBuilder
    func getTile(row : Int, col : Int)-> some View{
        switch vm.terrainBoard[row][col].name{
        case "h":
            Tile(size: 100, colored: Color.red, tileLocation: Coord(row, col))//House
        default:
            Tile(size: 100, colored: Color.green, tileLocation: Coord(row, col))
            
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
                                        getTile(row: row, col: col)
                                        if let piece = vm.board[row][col] {
                                            VStack{
                                                piece.getView().matchedGeometryEffect(id: "\(piece.id) view", in: nameSpace)
                                                Text("H \(piece.health) S \(piece.stamina-piece.movementCount)").matchedGeometryEffect(id:"\(piece.id) text", in: nameSpace)//.padding()
                                                Spacer()
                                            }.frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))//
                                        }
                                        
                                        
                                    }
                                    .onTapGesture {withAnimation{vm.handleTap(tapRow: row, tapCol: col)}}
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
                    .padding()
                }
                statusView
                    .frame(height: 200)
            }
        
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
            //            Text("Is Tapped: \(vm.isTapped.description)")
            Text(weaponry ? "Collected enough food for \(food) people" : "")
            //            Text(talk ? "" : "Nobody to talk to")
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
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 100, height: 50)
                        Text("Next Turn").foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}
import SwiftUI
struct TestingGPtSecond: View {
    @State var food = 0
    @State var weaponry = true
    @Namespace var nameSpace : Namespace.ID
    @State var talk = true
    @ObservedObject var vm : Board
    @ViewBuilder
    func getTile(row : Int, col : Int)-> some View{
        switch vm.terrainBoard[row][col].name{
        case "h":
            Tile(size: 100, colored: Color.red, tileLocation: Coord(row, col))//House
        default:
            Tile(size: 100, colored: Color.green, tileLocation: Coord(row, col))
            
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
                                        getTile(row: row, col: col)
                                        if let piece = vm.board[row][col] {
                                            VStack{
                                                piece.getView().matchedGeometryEffect(id: "\(piece.id) view", in: nameSpace)
                                                Text("H \(piece.health) S \(piece.stamina-piece.movementCount)").matchedGeometryEffect(id:"\(piece.id) text", in: nameSpace)//.padding()
                                                Spacer()
                                            }.frame(width: geo.size.width/Double(vm.colMax), height: geo.size.height/Double(vm.rowMax))//
                                        }
                                    }
                                    .onTapGesture {withAnimation{vm.handleTap(tapRow: row, tapCol: col)}}
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
                    .padding()
                }
                statusView
                    .frame(height: 200)
            }    }
    
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
            //            Text("Is Tapped: \(vm.isTapped.description)")
            Text(weaponry ? "Collected enough food for \(food) people" : "")
            //            Text(talk ? "" : "Nobody to talk to")
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
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20).frame(width: 100, height: 50)
                        Text("Next Turn").foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}
