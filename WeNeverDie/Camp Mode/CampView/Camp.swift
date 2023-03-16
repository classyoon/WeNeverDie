//
//  CampView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
struct CampView: View {
    @Binding var showBoard: Bool
    @ObservedObject var gameData: ResourcePool
    @State var shouldResetGame = false
    @State var showCureHelp = false
    @Binding var surivorsSentOnMission: Int
    var canSendMission: Bool {
        surivorsSentOnMission != 0
    }
    
    @State var degrees: Double = 0
    
    func campPassDay() {
        showBoard = shouldShowMap()
        gameData.passDay()
        
        print("Showing board = \(showBoard)")
        print("Sending \(gameData.survivorSent)")
        print("Sent \(surivorsSentOnMission)")
        gameData.survivorSent = surivorsSentOnMission
        print(surivorsSentOnMission)
        print("Sending \(gameData.survivorSent)")
        save(items: ResourcePoolData(resourcePool: gameData), key: key)
    }
    
    func shouldShowMap() -> Bool {
        if surivorsSentOnMission > 0 {
            return true
        }
        return false
    }
    
    // TODO: remove Timer from production. for testing purposes only
    //    let timer = Timer.publish(every: 10, on: .current, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                VStack {
                    Spacer()
                    //MARK: Stats
                    CampStats(gameData: gameData, shouldResetGame: $shouldResetGame, surivorsSentOnMission: $surivorsSentOnMission, showBoard: $showBoard)
                    Spacer()
                    Button {
                        campPassDay()
                        if canSendMission {
                            leavingSoundPlayer?.prepareToPlay()
                            leavingSoundPlayer?.play()
                        }
                    } label: {
                        VStack {
                            Image(systemName: "bed.double.circle.fill")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(.white)
                            Text("We should try to Sleep. Zombies can wait.")
                        }
                    }.padding()
                        .frame(maxHeight: 100)
                }
                
                
                Button {
                    withAnimation {
                        degrees = degrees == 0 ? 180 : 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // Code you want to be delayed
                        showBoard = true
                        StartingSoundPlayer?.prepareToPlay()
                        StartingSoundPlayer?.play()
                    }
                } label: {
                    VStack {
                        //MARK: Mission Start
                        Image("Bus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: .white, radius: canSendMission ? 5 : 0)
                            .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
                        Text("Start Mission")
                            .foregroundColor(.white)
                            .bold()
                    }
                }.disabled(!canSendMission)
                    .opacity(canSendMission ? 1 : 0.6)
                    .padding()
                    .frame(maxHeight: UIScreen.screenHeight * 0.4)
                HStack {
                    //MARK: Cure
                    CureProgressView(gameData: gameData, showCureHelp: $showCureHelp)
                        .foregroundColor(.primary)
                    Spacer()
                    TopButtons(gameData: gameData)
                        .frame(maxWidth: 70)
                        .padding()
                    Spacer()
                    
                }.padding()
                    .frame(maxHeight: UIScreen.screenHeight)
            }
            //MARK: Background
            .background(
                Image("Campground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(gameData.death || gameData.victory ? 0.5 : 1)
            ).ignoresSafeArea()
            
                .blur(radius: gameData.death || (gameData.victory && !gameData.AlreadyWon) ? 10 : 0)
            //MARK: Death
                .overlay {
                    gameData.death ?
                    DefeatView(gameData: gameData)
                        .padding()
                    : nil
                }.foregroundColor(.white)
            //MARK: Victory
                .overlay {
                    (gameData.victory && !gameData.AlreadyWon) ?
                    HStack {
                        Spacer()
                        VictoryView(gameData: gameData)
                            .background(Color(.systemBackground))
                            .cornerRadius(20)
                        Spacer()
                    }
                    : nil
                }
            // TODO: remove .onReceive from production. for testing purposes only
            //            .onReceive(timer) { _ in
            //                if gameData.victory {
            //                    gameData.victory = false
            //                } else {
            //                    gameData.victory = true
            //                }
            //            }
        }
    }
}

struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), gameData: ResourcePool(), surivorsSentOnMission: Binding.constant(0))
    }
}
