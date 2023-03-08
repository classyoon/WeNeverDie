//
//  ResourcePoolDataView.swift
//  WeNeverDieTests
//
//  Created by Conner Yoon on 3/8/23.
//

import SwiftUI

struct ResourcePoolDataView: View {
    @StateObject var vm = ResourcePoolDataDefaults.shared
    @State var foodResource : Int = 12
    var body: some View {
        List{
            Stepper("Food Resource \(foodResource)", value: $foodResource)
                .onChange(of: foodResource) { newValue in
                
                    vm.data?.foodResource = foodResource
                    vm.save(vm.data!)
                }
            Text("\(vm.data?.foodResource ?? 0)")
        }
    }
}

struct ResourcePoolDataView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcePoolDataView()
    }
}
