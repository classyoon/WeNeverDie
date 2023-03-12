//
//  PieceRotationTest.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/26/23.
//

import SwiftUI
enum Direction : CGFloat, CaseIterable, Identifiable {
    case up = 0, down = 180, left = 270, right = 90, upright = 45, downright = 135, upleft = 315, downleft = 225
    var id: Self { self }
    var text: String {
        switch self {
        case .up:
            return "Up"
        case .down:
            return "Down"
        case .left:
            return "Left"
        case .right:
            return "Right"
        case .upright:
            return "UpRight"
        case .downright:
            return "DRight"
        case .upleft:
            return "UpLeft"
        case .downleft:
            return "DLeft"
        }
    }
}
struct PieceRotationTest: View {
    @State private var direction: Direction = .up
    
    var body: some View {
        VStack{
            PieceDisplay(piece: playerUnit(name: "Jones", board: Board())).rotationEffect(.degrees(direction.rawValue))
            Picker("Direction: \(direction.rawValue)", selection: $direction) {
                ForEach(Direction.allCases){
                    Text("\($0.text)")
                    
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

struct PieceRotationTest_Previews: PreviewProvider {
    static var previews: some View {
        PieceRotationTest()
    }
}
