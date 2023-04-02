//
//  CustomIndicatorView.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 02/04/23.
//

import SwiftUI

struct CustomIndicatorView: View {
    
    /// View Properties
    var totalPages: Int
    var currentPage: Int
    var activeTint: Color = .black
    var inactiveTint: Color = .gray.opacity(0.5)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) {
                Circle()
                    .fill(currentPage == $0 ? activeTint : inactiveTint)
                    .frame(width: 4, height: 4)
            }
        }
    }
}

struct CustomIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
