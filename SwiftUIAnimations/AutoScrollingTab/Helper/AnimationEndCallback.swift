//
//  AnimationEndCallback.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 04/04/23.
//

import SwiftUI

struct AnimationState {
    //This will be used to observe the animation ending.
    var progress: CGFloat = 0
    var status: Bool = false
    
    mutating func startAnimation() {
        progress = 1.0
        status = true
    }
    
    mutating func reset() {
        progress = .zero
        status = false
    }
}

struct AnimationEndCallback<Value: VectorArithmetic>: Animatable, ViewModifier {
    var animatableData: Value {
        didSet {
            checkAnimationFinished()
        }
    }
    
    var endValue: Value
    var onEnd: () -> ()
    
    init(endValue: Value, onEnd: @escaping () -> ()) {
        self.endValue = endValue
        self.animatableData = endValue
        self.onEnd = onEnd
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    func checkAnimationFinished() {
        if animatableData == endValue {
            DispatchQueue.main.async {
                onEnd()
            }
        }
    }
}
