//
//  PomodoroViewModel.swift
//  PomodoroAppSwiftUI
//
//  Created by fmss on 27.12.2022.
//

import Foundation
import SwiftUI

enum PomodoroPeriod: Int {
    case work = 6
    case shortBreak = 3
    case longBreak = 5 // 15 20 25 30
    
    // Counter can be a maximum of 3
    static var counter = 0 {
        willSet(newValue){
            if self.counter <= 3 {
                self.counter = newValue
            }
        }
    }
}


enum Egg {
    case line
    case colorful
    
    func image() -> Image {
        switch self {
        case .line:
            return Image("eggLine")
        case .colorful:
            return Image("eggColorful")
        }
    }
}


class Pomodoro {
    static let shared = Pomodoro()
    let periods: [PomodoroPeriod] = [.work, .shortBreak, .work, .shortBreak, .work, .shortBreak, .work, .longBreak]

    private init() { }
}
