//
//  Extension.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 09/04/23.
//

import Foundation
import SwiftUI

///The following extension return the frame of the view as a completion

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func Offset(_ coordinateSpace: AnyHashable, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay(
                GeometryReader {
                    let rect = $0.frame(in: .named(coordinateSpace))
                    
                    Color.clear
                        .preference(key: Offsetkey.self, value: rect)
                        .onPreferenceChange(Offsetkey.self, perform: completion)
                }
            )
    }
}

extension View {
    @ViewBuilder
    func checkAnimationEnd<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> ()) -> some View {
        self
            .modifier(AnimationEndCallback2(for: value, onEnd: completion))
    }
}

//Animation onEnd Callback
struct AnimationEndCallback2<Value: VectorArithmetic>: Animatable, ViewModifier {
    var animatableData: Value {
        didSet {
            checkAnimationFinished()
        }
    }
    
    var endValue: Value
    var onEnd: () -> ()
    
    init(for endValue: Value, onEnd: @escaping () -> ()) {
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
