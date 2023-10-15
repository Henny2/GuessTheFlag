//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Henrieke Baunack on 10/14/23.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var scoreTitle = ""
    @State var alertShown = false
    var body: some View {
        ZStack{
            RadialGradient(stops: [.init(color: .cyan, location: 0.3), .init(color: .mint, location: 0.3)],center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
           // RadialGradient(colors: [.white, .mint], center: .top, startRadius: 200, endRadius: 500).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the flag").font(.largeTitle).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                VStack(spacing:15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.black)
                            .font(.subheadline).fontWeight(.heavy)
                        Text(countries[correctAnswer]).foregroundStyle(.black).font(.largeTitle).fontWeight(.semibold)
                    }
                    ForEach(0..<3){ number in
                        Button{
                            print("\(countries[number]) clicked")
                            flagTapped(number: number)
                            alertShown = true
                        } label: {
                            Image(countries[number]).clipShape(.rect(cornerRadius: 10))
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 30))
                //.padding(.horizontal, 20)
                Spacer()
                Text("Score: ???").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                Spacer()
            }.padding(20)
        }.alert(scoreTitle, isPresented: $alertShown){
            Button("Continue", action: restartGame)
        } message: {
            Text("Your score is ???")
        }
    }
    
    func flagTapped(number:Int){
        if number == correctAnswer {
            scoreTitle = "Correct!"
        } else{
            scoreTitle = "Wrong!"
        }
    }
    func restartGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

#Preview {
    ContentView()
}
