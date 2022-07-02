//
//  ContentView.swift
//  LearnX
//
//  Created by Adam Chen JingFan on 2022/6/28.
//

import SwiftUI

struct ContentView: View {
    @State var isActive : Bool = false
    
    @State private var menuPage = true
    @State private var selectedTable = 2
    @State private var avaliableQuestions = [2, 5, 10, 20]
    @State private var desiredQuestions = 5
    @State private var secondNumber = Int.random(in: 2..<13)
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .mint]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack {
                        Text("LearnX")
                            .font(.largeTitle.weight(.heavy))
                            .foregroundColor(.white)
                        Text("practice multiplication tables!")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                            .padding(.bottom, 10)
                            .opacity(0.8)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                            .padding(.horizontal, 50)
                        VStack {
                            HStack {
                                Text("Up to:")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.top, 15)
                            Stepper("  \(selectedTable)x Table", value: $selectedTable, in: 2...12)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .background(.white)
                                .cornerRadius(15)
                                .shadow(color: Color(red: 0.3, green: 0.3, blue: 0.7), radius: 7, x: -5, y: 5)
                        }
                        .padding(.horizontal, 50)
                        VStack {
                            HStack {
                                Text("Number of questions:")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.top, 15)
                            Picker("Choose an option", selection: $desiredQuestions) {
                                ForEach(avaliableQuestions, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                            //.frame(width: 500)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(.white)
                            .cornerRadius(15)
                            .shadow(color: Color(red: 0.3, green: 0.4, blue: 0.6), radius: 7, x: -5, y: 5)
                        }
                        .padding(.horizontal, 50)
                    }
                    Spacer()
                    Spacer()
                    VStack {
                        Text("Ready?")
                            .foregroundColor(.white)
                            .font(.title3)
                        ZStack {
                            NavigationLink(
                                destination: GameView(rootIsActive: self.$isActive, menuPage1: menuPage, selectedTable1: selectedTable, desiredQuestions1: desiredQuestions),
                                    isActive: self.$isActive
                            )
                            {
                                Label("Start practice", systemImage: "play.fill")
                            }
                            .isDetailLink(false)
                            .font(.title.bold())
                            .frame(width: 250, height: 60)
                            .foregroundColor(Color(red: 0.35, green: 0.65, blue: 0.9))
                            .background(.white)
                            .cornerRadius(999)
                            .shadow(color: .mint, radius: 10, x: 0, y: 0)
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .frame(maxWidth: 500)
            }
        }
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
