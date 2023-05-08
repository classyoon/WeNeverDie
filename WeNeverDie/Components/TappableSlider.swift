//
//  TappableSlider.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/8/23.
//

import SwiftUI


struct TappableSlider: View {
    @Binding var value: Float
    let range: ClosedRange<Float>
    let step: Float
    let isLeftHanded: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: isLeftHanded ? .trailing : .leading) {
                Rectangle()
                    .fill(Color.secondary.opacity(0.25))
                    .frame(height: 2)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.accentColor)
                    .frame(width: CGFloat(value / range.upperBound) * geometry.size.width, height: 10)
                
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 24, height: 24)
                    .offset(x: (isLeftHanded ? -1 : 1) * (CGFloat(value / range.upperBound) * geometry.size.width - 12))
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let newValue = Float((isLeftHanded ? (geometry.size.width - gesture.location.x) : gesture.location.x) / geometry.size.width) * range.upperBound
                        let roundedValue = round(newValue / step) * step
                        value = min(max(roundedValue, range.lowerBound), range.upperBound)
                    }
            )
        }
        .frame(height: 24)
    }
}

struct TappableSlider_Previews: PreviewProvider {
    @State static var value: Float = 0.5
    static var previews: some View {
        VStack {
            Text("Value: \(value)")
            TappableSlider(value: $value, range: 0...1, step: 0.01, isLeftHanded: true)
        }
        .padding()
    }
    
    
}


