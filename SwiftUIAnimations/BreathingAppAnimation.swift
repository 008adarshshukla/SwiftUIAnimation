//
//  BreathingAppAnimation.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 12/05/23.
//

import SwiftUI

struct BreathingAppAnimation: View {
    
    @State private var performAnimation: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Group {
                VStack(spacing: 5) {
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white], startPoint: .top, endPoint: .bottom)).opacity(0.5)
                        .frame(width: 150, height: 150)
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white], startPoint: .bottom, endPoint: .top)).opacity(0.5)
                        .frame(width: 150, height: 150)
                }
                
                
                VStack(spacing: 5) {
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white], startPoint: .top, endPoint: .bottom)).opacity(0.5)
                        .frame(width: 150, height: 150)
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white], startPoint: .bottom, endPoint: .top)).opacity(0.5)
                        .frame(width: 150, height: 150)
                }
                .rotationEffect(Angle(degrees: 60))
                
                VStack(spacing: 5) {
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white], startPoint: .top, endPoint: .bottom)).opacity(0.5)
                        .frame(width: 150, height: 150)
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white], startPoint: .bottom, endPoint: .top)).opacity(0.5)
                        .frame(width: 150, height: 150)
                }
                .rotationEffect(Angle(degrees: 120))
            }
            .rotationEffect(performAnimation ? .degrees(90) : .degrees(0))
            .scaleEffect(performAnimation ? 1 : 1/8)
            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: performAnimation)
        }
        .onAppear {
            performAnimation = true
        }
    }
}

struct BreathingAppAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BreathingAppAnimation()
    }
}
