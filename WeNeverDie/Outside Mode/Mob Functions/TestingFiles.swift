//
//  TestingFiles.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/19/23.
//

import SwiftUI
class viewModel : ObservableObject {
    @Published var number = 0
    func doAdd(){
        number+=1
    }
}
struct TestingFiles: View {
   @ObservedObject var vm = viewModel()
    var body: some View {
        VStack{
            Text("WE have \(vm.number) taps")
            Button("ADD"){
                vm.doAdd()
            }
        }
    }
}

struct TestingFiles_Previews: PreviewProvider {
    static var previews: some View {
        TestingFiles()
    }
}
