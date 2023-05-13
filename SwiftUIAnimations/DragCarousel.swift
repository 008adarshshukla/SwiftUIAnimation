//
//  InfiniteCarousel.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 13/05/23.
//

import SwiftUI

struct DragCarousel: View {
    
    @State private var currentPage: String = ""
    @State private var allPages: [Page] = []
    @State private var startPosition : CGPoint = .zero
    @State private var initiatedDrag = true
    @State private var nextPage: String = ""
    
    var body: some View {
        
        TabView(selection: $currentPage) {
            ForEach(allPages) { page in
                RoundedRectangle(cornerRadius: 20)
                    .fill(page.color.gradient)
                    .frame(height: 300)
                    .padding()
                    .tag(page.id)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                if initiatedDrag == true {
                                    self.startPosition = gesture.location
                                    initiatedDrag = false
                                }
                            }
                            .onEnded { gesture in
                                
                                let xDist =  abs(gesture.location.x - self.startPosition.x)
                                let yDist =  abs(gesture.location.y - self.startPosition.y)
                                
                                if self.startPosition.x > gesture.location.x && yDist < xDist {
                                    //MARK: Left
                                    print("Left")
                                    withAnimation(Animation.easeOut) {
                                        getNextPageOnLeftSwipe(page: page)
                                        self.currentPage = self.nextPage
                                    }
                                }
                                else if self.startPosition.x < gesture.location.x && yDist < xDist {
                                    //MARK: Right
                                    print("Right")
                                    withAnimation(Animation.easeOut) {
                                        getNextPageOnRightSwipe(page: page)
                                        self.currentPage = self.nextPage
                                    }
                                }
                                self.initiatedDrag.toggle()
                            }
                    )
                
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear {
            self.allPages = [
                Page(color: .red),
                Page(color: .blue),
                Page(color: .yellow),
                Page(color: .black),
                Page(color: .brown)
            ]
            currentPage = allPages[0].id
        }
        
    }
    
    func getNextPageOnLeftSwipe(page: Page) {
        guard let index = allPages.firstIndex(of: page) else {
            return
        }
        if(index < allPages.count - 1) {
            self.nextPage = allPages[index + 1].id
        } else {
            self.nextPage = allPages[0].id
        }
    }
    
    func getNextPageOnRightSwipe(page: Page) {
        guard let index = allPages.firstIndex(of: page) else {
            return
        }
        if(index == 0) {
            self.nextPage = allPages[allPages.count - 1].id
        } else {
            self.nextPage = allPages[index - 1].id
        }
    }
}

struct InfiniteCarousel_Previews: PreviewProvider {
    static var previews: some View {
        DragCarousel()
    }
}

struct Page: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var color: Color
}
