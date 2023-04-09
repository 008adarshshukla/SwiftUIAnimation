//
//  TextAnimation.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 06/04/23.
//

import SwiftUI

struct TextAnimation: View {
    
    @State private var timeElapsedInSeconds: Double = 0.0
    @State var currentDate = Date.now
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, World!")
                .font(Font.system(size: 46, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    
                )
                .opacity(timeElapsedInSeconds >= 0.0 && timeElapsedInSeconds <= 2.0 ? 1 : 0)
                .animation(Animation.easeOut(duration: 2).delay(4).repeatForever(), value: timeElapsedInSeconds)
                
            
            
            Text("I'm An")
                .font(Font.system(size: 46, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .opacity(timeElapsedInSeconds >= 2.0 && timeElapsedInSeconds <= 4.0 ? 1 : 0)
                .animation(Animation.easeOut(duration: 2).delay(4).repeatForever(), value: timeElapsedInSeconds)
            
            Text("iOS Developer")
                .font(Font.system(size: 46, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .blue, .green, .yellow],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .opacity(timeElapsedInSeconds >= 4.0 && timeElapsedInSeconds <= 5.99 ? 1 : 0)
                .animation(Animation.easeOut(duration: 2).delay(4).repeatForever(), value: timeElapsedInSeconds)
            
        }
        .onReceive(timer) { _ in
            timeElapsedInSeconds += 1
            print(timeElapsedInSeconds)
            if timeElapsedInSeconds == 7 {
                timeElapsedInSeconds = 0
            }
        }
    }
}

struct TextAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TextAnimation()
            .preferredColorScheme(.dark)
    }
}
