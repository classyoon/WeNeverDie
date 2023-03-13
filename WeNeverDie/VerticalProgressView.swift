//
//  VerticalProgressBar.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/12/23.
//

import SwiftUI

struct VerticalProgressBar: View {
    let progress = 0.3
    let max = 1.0
    let maxHeight = 200.0
    var body: some View {
        Rectangle()
            .stroke()
            .frame(width: 10, height: maxHeight)
            .overlay(
                VStack{
                    Spacer()
                    Rectangle()
                        .frame(width: 10, height: (progress/max) * maxHeight)
                }
            )
    }
}

struct VerticalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalProgressBar()
    }
}
