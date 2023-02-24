////
////  NavFiles.swift
////  WeNeverDie
////
////  Created by Conner Yoon on 1/31/23.
////
//
//import Foundation
//import SwiftUI
//enum NavigationPathes : CaseIterable {
//    case missionBoard
//    case managerScreen
//}
//enum Routes {
//    static let routes: [NavigationPathes: AnyView] = [.missionBoard: AnyView(BoardView(showBoard: vm: Board()))]//.managerScreen: AnyView(TestMerge(vm: Board())),
//    static func routerReturner(path: NavigationPathes)-> some View {
//        let index = Routes.routes.index(forKey: path)!
//        return Routes.routes[index].value
//    }
//}
//protocol NavigationManagerDelegate {
//    associatedtype Route = NavigationPathes
//    func pushView(_ newView : Route)
//    func popToRoot()
//    func pop()
//    func popUntil(_ targetRoute : Route)
//    
//}
//class NavManager : ObservableObject, NavigationManagerDelegate {
// 
//    
//    @Published var routes: [NavigationPathes] = []
//    
//    func pushView(_ newView: NavigationPathes) {
//        routes.append(newView)
//    }
//    func popToRoot() {
//        self.routes.removeAll()
//    }
//    
//    func pop() {
//        self.routes.removeLast()
//    }
//    
//    func popUntil(_ targetRoute: NavigationPathes) {
//        if self.routes.last != targetRoute{
//            self.routes.removeLast()
//            popUntil(targetRoute)
//        }
//    }
//}
//
//struct Navigator<Content: View>: View {
//    let content: (NavManager) -> Content
//    @StateObject var manager = NavManager()
//    
//    var body: some View {
//        NavigationStack(path: $manager.routes){
//            content(manager)
//        }.environmentObject(manager)
//    }
//}
//extension View {
//    func routeIterator()-> some View {
//        self.navigationDestination(for: NavigationPathes.self) { path in
//            Routes.routerReturner(path: path)
//        }
//    }
//}
