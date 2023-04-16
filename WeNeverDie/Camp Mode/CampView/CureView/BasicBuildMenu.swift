//
//  BasicBuildMenu.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 4/16/23.
//

import SwiftUI

struct BasicBuildMenu: View {
    @ObservedObject var GameData : ResourcePool
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(GameData.buildingProjects) { project in
                    
                    Button(action: {
                        if let index = GameData.buildingProjects.firstIndex(of: project) {
                            GameData.selectProject(index: index)
                        }
                    }) {
                        HStack {
                            Text("\(project.name)")
                            Spacer()
                            Text("\(project.matCost) Resources")
                        }
                    }.padding()
                    .disabled(GameData.resourcePts < project.matCost)
                }
                
                
                
            }.padding()
        }
    }
}

struct BasicBuildMenu_Previews: PreviewProvider {
    static var previews: some View {
        BasicBuildMenu(GameData: ResourcePool())
    }
}
