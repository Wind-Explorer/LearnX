//
//  Summary.swift
//  LearnX
//
//  Created by Adam Chen JingFan on 2022/6/30.
//

import SwiftUI

struct Summary: View {
    @Binding var shouldPopToRootView : Bool
    
    let finalScore: Int
    let totalScore: Int
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .mint]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("🎉")
                    .font(.largeTitle)
                Text("The end!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Your score:")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding(.top, 10)

                Text("\(finalScore) out of \(totalScore)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 10, x: 0, y: 0)
                Button {
                    self.shouldPopToRootView = false
                } label: {
                    Label("Quit", systemImage: "escape")
                }
                .font(.title.bold())
                .frame(width: 150, height: 60)
                .foregroundColor(.white)
                .background(Color(red: 0.55, green: 0.2, blue: 0.3))
                .cornerRadius(999)
                .shadow(color: .cyan, radius: 10, x: 0, y: 0)
                .padding(.top, 40)
                Spacer()
                Image(systemName: (totalScore - 1) <= finalScore ? "checkmark.bubble" : "exclamationmark.bubble")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text((totalScore - 1) <= finalScore ? "You are good at this!" : "You need more practice!")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
