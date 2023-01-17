//
//  CircleView.swift
//  PomodoroAppSwiftUI
//
//  Created by fmss on 26.12.2022.
//

import SwiftUI

struct CircleProgress: View {
    @State private var progress: CGFloat = 0
      let duration: Double
      let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
      var body: some View {
         ZStack {
            Circle()
               .stroke(Color.gray, lineWidth: 20)
            Circle()
               .trim(from: 0, to: progress)
               .stroke(Color.blue, lineWidth: 20)
               .rotationEffect(.degrees(-90))
               .onReceive(timer) { _ in
                  if self.progress < 1 {
                     self.progress += 1 / self.duration
                  }
               }
         }
         .frame(width: 200, height: 200)
         .animation(.linear)
      }
}

struct CircleProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgress(duration: 3)
    }
}
