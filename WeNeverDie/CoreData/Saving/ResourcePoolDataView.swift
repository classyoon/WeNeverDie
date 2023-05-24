//
//  ResourcePoolDataView.swift
//  WeNeverDieTests
//
//  Created by Conner Yoon on 3/8/23.
//

import SwiftUI

//struct ResourcePoolDataView: View {
//    @StateObject var vm = ResourcePoolDataDefaults.shared
//    @State var foodStored : Int = 12
//    var body: some View {
//        List{
//            Stepper("Food Resource \(foodStored)", value: $foodStored)
//                .onChange(of: foodStored) { newValue in
//                
//                    vm.data?.stockpile.foodStored = foodStored
//                    vm.save(vm.data!)
//                }
//            Text("\(vm.data?.stockpile.foodStored ?? 0)")
//        }
//    }
//}
//
//struct ResourcePoolDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResourcePoolDataView()
//    }
//}
