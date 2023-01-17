//
//  ContentView.swift
//  PomodoroAppSwiftUI
//
//  Created by fmss on 26.12.2022.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                NavigationLink {
                    PomodoroPeriodView()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.pink)
                            .frame(height: 120)
                        Text("Pomodoro Timer")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            
                }

                
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.purple)
                        .frame(height: 120)
                    Text("Calendar")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        
                }
                Spacer()
            }.padding()
        }.padding(0)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
