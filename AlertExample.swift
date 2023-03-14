//
//  AlertExample.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 3/14/23.
//

import SwiftUI

struct AlertExample: View {
    @State private var isShowingMessage = false
    
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button {
                isShowingMessage.toggle()
            } label: {
                Text("Show message")
            }

        }
            .overlay(
                Group{
                    if isShowingMessage {
                        VStack{
                            Text("Message to the user:")
                            HStack{
                                Button(action: {
                                    isShowingMessage = false
                                }, label: {
                                    Text("Drop food")
                                })
                                .buttonStyle(.bordered)
                                Button(action: {
                                    isShowingMessage = false
                                }, label: {
                                    Text("Run")
                                })
                                .buttonStyle(.bordered)
                            }
                        }
                        .frame(width: 300, height: 300)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.thickMaterial)
                        )
                        

                    }
                }
            )
    }
}

struct AlertExample_Previews: PreviewProvider {
    static var previews: some View {
        AlertExample()
    }
}
