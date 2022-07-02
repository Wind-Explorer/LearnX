import SwiftUI

struct GameView: View {
    @Binding var rootIsActive : Bool
    
    let menuPage1: Bool
    let selectedTable1: Int
    let desiredQuestions1: Int
    
    @State private var userInput = 0
    @State private var showingMessage = false
    @State private var userScore = 0
    @State private var correct = false
    @State private var secondNumber1 = Int.random(in: 2..<13)
    @State private var currentProgress = 0
    @State private var topIcon = "text.bubble"
    @State private var colorValues = ["rightRed": 0.3, "rightGreen": 0.8, "rightBlue": 0.4, "wrongRed": 0.8, "wrongGreen": 0.3, "wrongBlue": 0.4]
    @State private var checked = false
    @State private var buttonText = "Submit"
    @State private var buttonIcon = "paperplane.fill"
    
    @State private var redColor = 1.0
    @State private var greenColor = 1.0
    @State private var blueColor = 1.0
    
    @FocusState private var keyboardShown: Bool
    
    func showSummary() -> some View {
        return Summary(shouldPopToRootView: self.$rootIsActive, finalScore: userScore, totalScore: desiredQuestions1)
    }
    
    func verifyAns(_ ans: Int) {
        if userInput == selectedTable1 * secondNumber1 {
            checked = true
            userScore += 1
            currentProgress += 1
            redColor = 0.3
            greenColor = 0.8
            blueColor = 0.4
            topIcon = "checkmark.bubble"
            correct = true
        } else {
            checked = true
            currentProgress += 1
            redColor = 0.8
            greenColor = 0.3
            blueColor = 0.4
            topIcon = "exclamationmark.bubble"
            correct = false
        }
    }
    
    func askQuestion() {
        userInput = 0
        correct = false
        checked = false
        buttonText = "Submit"
        buttonIcon = "paperplane.fill"
        redColor = 1.0
        greenColor = 1.0
        blueColor = 1.0
        secondNumber1 = Int.random(in: 2..<13)
        userInput = 0
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .mint]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Image(systemName: topIcon)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("What is \(selectedTable1) x \(secondNumber1)?")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.white)
                HStack {
                    Spacer()
                    TextField("Answer:", value: $userInput ,format: .number)
                        .keyboardType(.decimalPad)
                        .focused($keyboardShown)
                        .font(.title)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(Color(red: redColor, green: greenColor, blue: blueColor))
                        .cornerRadius(15)
                        .shadow(color: Color(red: 0.3, green: 0.3, blue: 0.7), radius: 7, x: -5, y: 5)
                        .animation(.default, value: redColor)
                        .animation(.default, value: greenColor)
                        .animation(.default, value: blueColor)
                    
                    Spacer()
                }
                .padding(.horizontal, 50)
                
                ZStack {
                    if currentProgress >= desiredQuestions1 {
                        NavigationLink {
                            Summary(shouldPopToRootView: self.$rootIsActive, finalScore: userScore, totalScore: desiredQuestions1)
                        } label: {
                            Label("Summary", systemImage: "arrow.right.circle")
                        }
                        .isDetailLink(false)
                        .font(.title.bold())
                        .frame(width: 200, height: 60)
                        .foregroundColor(Color(red: 0.35, green: 0.65, blue: 0.9))
                        .background(.white)
                        .cornerRadius(999)
                        .shadow(color: .cyan, radius: 10, x: 0, y: 0)
                        .padding(.top, 40)
                    } else {
                        Button {
                            if !correct {
                                buttonText = "Next"
                                buttonIcon = "arrow.right.circle"
                            }
                            if !correct && !checked {
                                verifyAns(userInput)
                            } else if !correct && checked {
                                topIcon = "text.bubble"
                                askQuestion()
                            } else if correct {
                                topIcon = "text.bubble"
                                askQuestion()
                            }
                        } label: {
                            Label(buttonText, systemImage: buttonIcon)
                        }
                        .font(.title.bold())
                        .frame(width: 180, height: 60)
                        .foregroundColor(Color(red: 0.35, green: 0.65, blue: 0.9))
                        .background(.white)
                        .cornerRadius(999)
                        .shadow(color: .cyan, radius: 10, x: 0, y: 0)
                        .padding(.top, 40)
                    }
                }
                Spacer()
                Text("\(userScore) out of \(desiredQuestions1)")
                    .font(.title.weight(.heavy))
                    .foregroundColor(.white)
                Text("\(currentProgress) questions done")
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(maxWidth: 500)
        }
        .navigationBarBackButtonHidden(true)
    }
}
