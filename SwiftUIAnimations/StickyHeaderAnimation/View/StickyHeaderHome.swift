//
//  StickyHeaderHome.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 09/04/23.
//

import SwiftUI

struct StickyHeaderHome: View {
    
    @State private var activeTab: ProductType = .iphone
    @Namespace private var namespace
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                //LazyVStack for pinning the Views at the top while Scrolling
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                    Section {
                        
                    } header: {
                        scrollableTabs()
                    }

                }
            }
        }
        .navigationTitle("Apple Store")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.purple, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    //Scrollable tabs
    @ViewBuilder
    func scrollableTabs() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(ProductType.allCases, id: \.rawValue) { type in
                    Text(type.rawValue)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    //Active tab Indicator
                        .background(alignment: .bottom) {
                            if activeTab == type {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(height: 5)
                                    .padding(.horizontal, -8)
                                    .offset(y: 15)
                                //for smooth transformation of one background view to another.
                                    .matchedGeometryEffect(id: "ACTIVE TAB", in: namespace)
                            }
                        }
                        .padding(.horizontal, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                activeTab = type
                            }
                        }
                }
            }
            .padding(.vertical, 15)
        }
        .background {
            Rectangle()
                .fill(Color.purple)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
        }
    }
}

struct StickyHeaderHome_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
