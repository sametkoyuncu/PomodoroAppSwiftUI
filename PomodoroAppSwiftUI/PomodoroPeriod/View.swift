//
//  PomodoroPeriod.swift
//  PomodoroAppSwiftUI
//
//  Created by fmss on 27.12.2022.
//

import SwiftUI
import AVFoundation

struct PomodoroPeriodView: View {
    @State private var eggList: [Egg] = [.line, .line, .line, .line]
    @State private var periodCounter = 0
    @State private var eggCounter = 0
    @State private var isTimerRunning = false
    @State private var showAlert = false
    @State private var periodDuration = Pomodoro.shared.periods[0].rawValue
    @State private var periodTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // circle
    @State private var circleProgress: CGFloat = 0
    @State private var circleDuration: Double = Double(Pomodoro.shared.periods[0].rawValue)
    @State private var circleTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // pomodoro period
    @State private var period: PomodoroPeriod = Pomodoro.shared.periods[0]
    // audio
    @State var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                ForEach(eggList, id: \.self) { egg in
                    egg.image()
                        .resizable()
                        .opacity(egg == .colorful ? 1 : 0.1)
                        .frame(width: 48, height: 48)
                }
            }.padding()
            ZStack {
                // MARK: - circle
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 5)
                Circle()
                    .trim(from: 0, to: circleProgress)
                    .stroke(period == .work ? Color.blue : Color.green , lineWidth: 5)
                    .rotationEffect(.degrees(-90))
                    .onReceive(circleTimer) { _ in
                        if isTimerRunning {
                            if self.circleProgress <= 1 {
                                self.circleProgress += 1 / self.circleDuration
                            }
                        }
                    }
                // MARK: - time counter
                VStack {
                    Text("\(periodDuration / 60):\(periodDuration % 60)")
                        .font(.largeTitle)
                    HStack {
                        Button(action: toggleTimer) {
                            Text(isTimerRunning ? "Pause" : "Start")
                        }
                        Button(action: resetTimer) {
                            Text("Reset")
                        }
                    }
                }
                .onReceive(periodTimer) { _ in
                    if isTimerRunning {
                        updateTimer()
                        if periodDuration == 0 {
                           endTimer()
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: Text("Time is up!"), dismissButton: .default(Text("OK")))
                }
            }
            .frame(width: 240, height: 240)
        .animation(.linear)
        }
        
        
        
    }
    
    func playSound() {
         let soundURL = Bundle.main.url(forResource: "alarm", withExtension: "wav")
         do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            audioPlayer.play()
         } catch {
            print(error)
         }
      }
    
    func updateTimer() {
        periodDuration -= 1
    }
    
    // start/stop timer
    func toggleTimer() {
        isTimerRunning.toggle()
    }
    
    func endTimer() {
        showAlert = true
        self.playSound()
        self.circleProgress += 1 / self.circleDuration
        
        // update egg
        if period == .work {
            eggList[eggCounter] = .colorful
            
            if eggCounter == 3 {
                eggCounter = 0
                eggList = [.line, .line, .line, .line]
            } else {
                eggCounter += 1
            }
        }
        // update period
        if periodCounter == 7 {
            periodCounter = 0
        } else {
            periodCounter += 1
        }
        period = Pomodoro.shared.periods[periodCounter]
        
        // reset values
        resetTimer()
    }
    
    func resetTimer() {
        periodDuration = period.rawValue
        circleDuration = Double(period.rawValue)
        circleProgress = 0
        isTimerRunning = false
    }
}

struct PomodoroPeriodView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroPeriodView()
    }
}
