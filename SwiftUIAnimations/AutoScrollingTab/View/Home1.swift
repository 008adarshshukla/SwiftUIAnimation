//
//  Home.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 04/04/23.
//

import SwiftUI

struct Home1: View {
    
    @State private var activeTab: Tab = .constellation
    @State private var scrollProgress: CGFloat = .zero
    @State private var tapState: AnimationState = .init()
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                TabIndicatorView()
                
                TabView(selection: $activeTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        TabImageView(tab)
                            .tag(tab)
                            .offsetX(activeTab == tab) { rect in
                                let minX = rect.minX
                                let pageOffset = minX - (size.width * CGFloat(tab.index))
                                ///Converting Page Offset into progress
                                let pageProgress = pageOffset / size.width
                                
                                ///Limiting the scroll progress between the first and the last tab and avoiding over scrolling
                                ///Simply disable when the tapState is true
                                if !tapState.status {
                                    scrollProgress = max(min(pageProgress, 0), -CGFloat(Tab.allCases.count - 1))
                                }
                                
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    ///Tab Indicator View
    @ViewBuilder
    func TabIndicatorView() -> some View {
        GeometryReader {
            let size = $0.size
            //We are going to display only three tab's in entire screen.
            let tabWidth = size.width / 3
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Text(tab.rawValue)
                        .font(.title3.bold())
                        .foregroundColor(activeTab == tab ? .primary : .gray)
                        .frame(width: tabWidth)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                activeTab = tab
                                scrollProgress = -CGFloat(tab.index)
                                tapState.startAnimation()
                            }
                        }
                }
            }
            .modifier(
                AnimationEndCallback(endValue: tapState.progress, onEnd: {
                    print("Animation finished")
                    tapState.reset()
                })
            )
            .frame(width: CGFloat(Tab.allCases.count) * tabWidth)
            //to start at center
            .padding(.leading, tabWidth)
            .offset(x: scrollProgress * tabWidth)
        }
        .frame(height: 50)
        .padding(.top, 15)
    }
    
    /// Image View
    @ViewBuilder
    func TabImageView(_ tab: Tab) -> some View {
        GeometryReader {
            let size = $0.size
            
            Image(tab.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

struct Home1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 In swiftUI Page Tab View, when the page is swiped, the offset will return to zero, but there is a way to find the complete scroll offset with the help of the index.
 
 formula -
 totalOffset = activeTabMinX - (PageWidth * activeTabIndex)
 */
