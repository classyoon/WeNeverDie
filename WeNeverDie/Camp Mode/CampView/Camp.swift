//
//  CampView.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 2/2/23.
//

import SwiftUI
struct CampView: View {
    @Binding var showBoard: Bool
    @ObservedObject var GameData: ResourcePool
    @State var ResetGame = false
    @State var showCureHelp = false
    @Binding var surivorsSentOnMission: Int
    var canSendMission: Bool {
        surivorsSentOnMission != 0
    }

    @State var degrees: Double = 0

    func campPassDay() {
        GameData.passDay()
        showBoard = shouldShowMap()
        print(showBoard)
        print("Sending \(GameData.survivorSent)")
        print("Sent \(surivorsSentOnMission)")
        GameData.survivorSent = surivorsSentOnMission
        print(surivorsSentOnMission)
        print("Sending \(GameData.survivorSent)")
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
                    ProgressView(value: Double(GameData.WinProgress), total: Double(GameData.WinCondition))
                        .padding()
                        .animation(.easeInOut(duration: 3), value: GameData.WinProgress)
                    Button {
                        showCureHelp = true
                    } label: {
                        Image(systemName: GameData.victory ? "syringe.fill" : "syringe")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxHeight: 70)
                    }
                    .frame(width: progressDim.size.width * 0.1)

                }.alert("Cure Progress \(String(format: " %.0f%%", GameData.WinProgress / GameData.WinCondition * 100))", isPresented: $showCureHelp) {
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
                    TopButtons()
                        .frame(maxWidth: 70)
                        .padding()

                }.padding()
                    .frame(maxHeight: UIScreen.screenHeight)
                VStack {
                    Spacer()
                    CampStats(GameData: GameData, ResetGame: ResetGame, surivorsSentOnMission: $surivorsSentOnMission)
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
                    .opacity(GameData.death || GameData.victory ? 0.5 : 1)
            ).ignoresSafeArea()

            .blur(radius: GameData.death || GameData.victory ? 10 : 0)
            .overlay {
                GameData.death ?
                    DefeatView(GameData: GameData)
                    .padding()
                    : nil
            }
            .overlay {
                (GameData.victory && GameData.AlreadyWon) ?
                    VictoryView(GameData: GameData)
                    .padding()
                    : nil
            }
        }.foregroundColor(.white)
    }
}

struct CampView_Previews: PreviewProvider {
    static var previews: some View {
        CampView(showBoard: Binding.constant(false), GameData: ResourcePool(surviors: 3, food: 10), surivorsSentOnMission: Binding.constant(0))
    }
}
