//
//  Battle.swift
//  WeNeverDie
//
//  Created by Tim Yoon on 12/2/22.
//

import Foundation

enum PieceType: CaseIterable {
    case king, pawn, bishop, checker
}
enum BattleResult: CaseIterable {
    case attackerWin, defenderWin, bothSurvive, bothDie
}
protocol BattleProtocol {
    func battle(attacker: PieceType, defender: PieceType) -> BattleResult
}
extension BattleProtocol {
    func battle(attacker: PieceType, defender: PieceType) -> BattleResult {
        .attackerWin
    }
}
