//
//  ScrollOffserModifier.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 04/04/23.
//

import SwiftUI

struct Offsetkey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    //addObserver to Observe the scroll offset of only active page.
    @ViewBuilder
    func offsetX(_ addObserver: Bool = false, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        
                        Color.clear
                            .preference(key: Offsetkey.self, value: rect)
                            .onPreferenceChange(Offsetkey.self,perform: completion)
                    }
                }
            }
    }
}

