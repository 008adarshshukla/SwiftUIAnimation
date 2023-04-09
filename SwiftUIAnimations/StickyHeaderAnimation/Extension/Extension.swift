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
