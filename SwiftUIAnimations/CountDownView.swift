//
//  CountDownView.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 16/05/23.
//

import SwiftUI

struct CountDownView: View  {
    
    @State private var first: String = "1"
    @State private var second: String = "2"
    @State private var third: String = "3"
    @State private var animate1 = false
    @State private var animate2 = false
    @State private var animate3 = false
    @State private var count: Int = 1
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Text(third)
                .font(.system(size: animate2 ? 100 : 50))
                .opacity(animate3 ? 0 : 99)
                .animation(Animation.easeOut(duration: 1), value: animate3)
                .onAppear {
                    animate3 = true
                }
            if count == 2 {
                Text(second)
                    .font(.system(size: animate2 ? 100 : 50))
                    .opacity(animate2 ? 0 : 99)
                    .animation(Animation.easeOut(duration: 1), value: animate2)
                    .onAppear {
                        third = ""
                        animate2 = true
                    }
            }
            if count == 3 {
                Text(first)
                    .font(.system(size: animate2 ? 100 : 50))
                    .opacity(animate1 ? 0 : 99)
                    .animation(Animation.easeOut(duration: 1), value: animate1)
                    .onAppear {
                        second = ""
                        animate1 = true
                    }
            }
        }
        .onReceive(timer) { _ in
            count += 1
        }
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
    }
}

