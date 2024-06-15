//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Gunther Masi Haas on 14/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var numberQuestions = 0
    @State private var showingFinalScore = false
    @State private var showGame = true
    
    var body: some View {
            ZStack {
                if showGame {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    Spacer()
                    Spacer()
                    Text("Score \(userScore)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    Spacer()
                    VStack(spacing: 15){
                        VStack{
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.heavy))
                                .foregroundStyle(.secondary)
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                        }
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 30))
                }
                .padding()
            } else {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    Text("fin")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                        .fontDesign(.serif)
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        .alert("Final Score:", isPresented: $showingFinalScore){
            Button("Yes", action:  askReset)
            Button("No", action: stopGame)
        } message: {
            Text("Your final score is \(userScore). ")
        }
}
    
    func flagTapped(_ number: Int) {
        numberQuestions += 1
        if (numberQuestions > 8) {
            showingFinalScore = true
        } else {
            if number == correctAnswer {
                scoreTitle = "Correct"
                userScore += 1
            } else {
                scoreTitle = "Wrong. That is the flag of \(countries[number])"
            }
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func askReset() {
        numberQuestions = 0
        userScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false
    }
    
    func stopGame() {
        showGame = false
    }
}

#Preview {
    ContentView()
}
