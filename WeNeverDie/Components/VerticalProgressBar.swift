//
//  VerticalProgressBar.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct VerticalProgressBar: View {
    let progress: Double
    let max: Double
    let color: Color
    let maxHeight: Double
    
    init(progress: Int, max: Int, color: Color = .accentColor, maxHeight: Double = 200.0) {
        self.progress = Double(progress)
        self.max = Double(max)
        self.color = color
        self.maxHeight = maxHeight
    }
    init(progress: Double, max: Double = 1.0, color: Color = .accentColor, maxHeight: Double = 200.0){
        self.progress = progress
        self.max = max
        self.color = color
        self.maxHeight = maxHeight
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .stroke()
            .frame(width: 10, height: maxHeight)
            .overlay(
                VStack{
                    RoundedRectangle(cornerRadius: 3)
                        .fill(color)
                        .frame(width: 10, height: getHeight(progress: progress, max: max))
                        .offset(y: getOffsetHeight(progress: progress, max: max))
                }
            )
    }
    
    private func getHeight(progress: Double, max: Double)-> Double {

        return min((progress/max) * maxHeight, maxHeight)
    }
    private func getOffsetHeight(progress: Double, max: Double) -> Double {
        if progress >= max {
            return 0.0
        }
        return  (maxHeight / 2) - ((progress/max) * maxHeight / 2)
    }
}
class DataVM: ObservableObject {
    @Published var progress: Int = 0
    @Published var max: Int = 10
}
struct WrappedVerticalProgressBar: View {
    @StateObject var vm = DataVM()
    
    var body: some View {
        VStack {
            VerticalProgressBar(progress: vm.progress, max: vm.max)
            
            Button {
                vm.progress += 1
            } label: {
                Text("increase")
            }
            Text("Progress: \(vm.progress)")
            Text("Max: \(vm.max)")
        }
    }
}
struct VerticalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        WrappedVerticalProgressBar()
    }
}
