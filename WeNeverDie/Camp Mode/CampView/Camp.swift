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
    @State var ResetGame = false
    @State var showCureHelp = false
    @Binding var surivorsSentOnMission: Int
    var canSendMission: Bool {
        surivorsSentOnMission != 0
    }

    @State var degrees: Double = 0

    func campPassDay() {
        gameData.passDay()
        showBoard = shouldShowMap()
        print(showBoard)
        print("Sending \(gameData.survivorSent)")
        print("Sent \(surivorsSentOnMission)")
        gameData.survivorSent = surivorsSentOnMission
        print(surivorsSentOnMission)
        print("Sending \(gameData.survivorSent)")
    }

    func shouldShowMap() -> Bool {
        if surivorsSentOnMission > 0 {
            return true
        }
        return false
    }

    var cureProgress: some View {
        GeometryReader { progressDim in
            HStack {
                HStack {
                    ProgressView(value: Double(gameData.WinProgress), total: Double(gameData.WinCondition))
                        .padding()
                        .animation(.easeInOut(duration: 3), value: gameData.WinProgress)
                    Button {
                        showCureHelp = true
                    } label: {
                        Image(systemName: gameData.victory ? "syringe.fill" : "syringe")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxHeight: 70)
                    }
                    .frame(width: progressDim.size.width * 0.1)

                }.alert("Cure Progress \(String(format: " %.0f%%", gameData.WinProgress / gameData.WinCondition * 100))", isPresented: $showCureHelp) {
                    Button("Understood", role: .cancel) {}
                } message: {
                    Text("Keep survivors at home to make progress faster.")
                }
                Spacer()
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                HStack {
                    cureProgress
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: min(UIScreen.screenHeight, UIScreen.screenWidth) - 70, maxHeight: min(UIScreen.screenHeight, UIScreen.screenWidth) - 70)
                        .rotationEffect(Angle(degrees: -90))
                        .foregroundColor(.blue)
                    Spacer()
                    TopButtons(gameData: gameData)
                        .frame(maxWidth: 70)
                        .padding()

                }.padding()
                    .frame(maxHeight: UIScreen.screenHeight)
                VStack {
                    Spacer()
                    CampStats(gameData: gameData, ResetGame: $ResetGame, surivorsSentOnMission: $surivorsSentOnMission, showBoard: $showBoard)
                    Spacer()
                    Button {
                        campPassDay()
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
                    }
                } label: {
                    VStack {
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
            }
            .background(
                Image("Campground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(gameData.death || gameData.victory ? 0.5 : 1)
            ).ignoresSafeArea()

            .blur(radius: gameData.death || gameData.victory ? 10 : 0)
            .overlay {
                gameData.death ?
                    DefeatView(gameData: gameData)
                    .padding()
                    : nil
            }
            .overlay {
                (gameData.victory && gameData.AlreadyWon) ?
                    VictoryView(gameData: gameData)
                    .padding()
                    : nil
            }
        }.foregroundColor(.white)
    }
}

struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), gameData: ResourcePool(surviors: 3, food: 10), surivorsSentOnMission: Binding.constant(0))
    }
}
