//
//  SaveTestView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/8/23.
//

import SwiftUI
struct ModelData : Identifiable & Codable {
    var id = UUID()
    var name = "Steve"
}
struct SaveTestView: View {
    @State var modelData = ModelData()
    let key = "Model Data"
    @State var returnedData = ModelData()
    var body: some View {
        VStack {
            TextField("name", text: $modelData.name)
                .textFieldStyle(.roundedBorder)
                .padding()
            Text("\(returnedData.name)")
            HStack{
                Button {
                    save(items: modelData, key: key)
                } label: {
                    Text("Save")
                }
                Button {
                    returnedData = load(key: key) ?? ModelData()
                } label: {
                    Text("Fetch")
                }


            }
        }
    }
}

struct SaveTestView_Previews: PreviewProvider {
    static var previews: some View {
        SaveTestView()
    }
}
