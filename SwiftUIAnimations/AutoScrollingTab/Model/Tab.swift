//
//  Tab.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 04/04/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case constellation = "Constellation"
    case fire = "Fire"
    case fireworks = "Fireworks"
    case flower = "Flower"
    case planet = "Planet"
    case smoke = "Smoke"
    
    ///Tab Index
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
    
    ///Total Count
    var count: Int {
        return Tab.allCases.count
    }
}
