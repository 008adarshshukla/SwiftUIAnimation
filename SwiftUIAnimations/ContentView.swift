//
//  ContentView.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 01/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TextAnimation()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
