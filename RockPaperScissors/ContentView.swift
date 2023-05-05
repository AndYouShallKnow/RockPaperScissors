//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gerard White on 04/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shouldWin = false
    @State private var gameOver = false

    @State private var choices = ["Rock", "Paper", "Scissors"]
    @State private var aiChoice = Int.random(in: 0...2)
    @State private var score = 0
    @State private var gameCount = 0

    
    @State private var playerChoice = ""
    @State private var verdict = ""
    
    


    
    var body: some View {
        
        VStack {
            Spacer()
            Spacer()
            
            if (shouldWin){
                Text("The player should win vs. \(choices[aiChoice])")
            } else {
                Text("The player should lose vs. \(choices[aiChoice])")
            }
            
            Text("Score: \(score) ")
            Text("Game: \(gameCount) ")

            Text("RESULT: \(verdict)")
                .foregroundColor((verdict == "Correct" ? .green : .red))
            Spacer()
            
            ForEach(0..<3) { number in
                Button(choices[number]) {
                    buttonPressed(number)
                }
                
            }.padding()
                .font(.largeTitle)
            
            
            
            
            
        }
        .alert("Game Over", isPresented: $gameOver){
            Button("Reset", action: reset)
        } message: {
            Text("Game Over! Your score is \(score)")
        }

        
        
        
    }
    
    func reset() {
        gameOver = false
        gameCount = 0
        score = 0
        aiChoice = Int.random(in: 0...2)
        shouldWin.toggle()
        
    }
    
    func buttonPressed(_ number : Int){
        
        playerChoice = choices[number]
        
        if (isCorrect(inString: playerChoice)) {
            verdict = "Correct"
            score += 1
            
        } else {
            verdict = "Incorrect"
            score -= 1

            
        }
        
        aiChoice = Int.random(in: 0...2)
        shouldWin.toggle()
        gameCount += 1
        
        if (gameCount >= 3){
            gameOver = true
        }
        
    }
    
    
    
    func isCorrect(inString: String) -> Bool{
        var isCorrect = false
        
        if (shouldWin) {
            
            if (choices[aiChoice] == "Rock"){
                if(playerChoice == "Paper" ){
                    isCorrect = true
                }
            }
            
            if (choices[aiChoice] == "Scissors"){
                if(playerChoice == "Rock" ){
                    isCorrect = true
                }
            }
            
            if (choices[aiChoice] == "Paper"){
                if(playerChoice == "Scissors" ){
                    isCorrect = true
                }
            }
            
        } else if (!shouldWin) {
            if (choices[aiChoice] == "Rock"){
                if(playerChoice == "Scissors" || playerChoice == "Rock"){
                    isCorrect = true
                }
            }
            
            if (choices[aiChoice] == "Scissors"){
                if(playerChoice == "Scissors" || playerChoice == "Paper"){
                    isCorrect = true
                }
            }
            
            if (choices[aiChoice] == "Paper"){
                if(playerChoice == "Paper" || playerChoice == "Rock"){
                    isCorrect = true
                }
                
            }
        }
        return isCorrect
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
