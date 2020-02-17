//
//  ContentView.swift
//  Bullseye
//
//  Created by Luiz França on 16/02/20.
//  Copyright © 2020 Luiz França. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to: \(target)")
            }
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            
            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $alertIsVisible, content: { () -> Alert in
                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(sliderValueRounded()).\n"
                    + "You scored \(pointsForCurrentRound())"), dismissButton: .default(Text("Awesome!")) {
                        self.score += self.pointsForCurrentRound()
                        self.target = self.nextTarget()
                        self.round += 1
                    })
            })
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    Text("Start over!")
                }
                Spacer()
                Text("Score: \(score)")
                Spacer()
                Text("Round: \(round)")
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        abs(sliderValueRounded() - target)
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        
        return maximumScore - difference + bonus
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func nextTarget() -> Int {
        Int.random(in: 1...100)
    }
    
    func startNewGame() {
        target = nextTarget()
        sliderValue = 50.0
        score = 0
        round = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}

