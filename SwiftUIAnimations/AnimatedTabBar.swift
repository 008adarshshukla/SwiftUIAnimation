//
//  AnimatedTabBar.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 14/05/23.
//

import SwiftUI

struct AnimatedTabBar: View {
    
    @State private var activeTab: Tabs = .home
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
    var body: some View {
        VStack {
            TabView(selection: $activeTab) {
                
                Text("Home")
                    .tag(Tabs.home)
                    //MARK: Hiding Native Tab Bar
                    .toolbarBackground(.hidden, for: .tabBar)
                
                Text("Services")
                    .tag(Tabs.services)
                    //MARK: Hiding Native Tab Bar
                    .toolbarBackground(.hidden, for: .tabBar)
                    
                
                Text("Partners")
                    .tag(Tabs.partners)
                    //MARK: Hiding Native Tab Bar
                    .toolbarBackground(.hidden, for: .tabBar)
                    
                
                Text("Activity")
                    .tag(Tabs.activity)
                    //MARK: Hiding Native Tab Bar
                    .toolbarBackground(.hidden, for: .tabBar)
                    
            }
             CustomTabBar()
        }
        
    }
    
    //MARK: Custom Tab Bar
    @ViewBuilder
    func CustomTabBar(_ tintColor: Color = Color.blue, _ inactiveTintColor: Color = Color.cyan) -> some View {
        
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tabs.allCases, id: \.rawValue) {
                TabBarItem(
                    tint: tintColor,
                    inactiveTint: inactiveTintColor,
                    tab: $0, animation: animation,
                    activeTab: $activeTab, position: $tabShapePosition)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        //MARK: Adding Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
        .background {
            TabShape(curveMidPointX: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tintColor.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        }
    }
}

struct TabBarItem: View {
    
    var tint: Color
    var inactiveTint: Color
    var tab: Tabs
    var animation: Namespace.ID
    @Binding var activeTab: Tabs
    @Binding var position: CGPoint
    @State private var tabPosition: CGPoint  = .zero
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : tint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ActiveTab", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition({ rect in
            self.tabPosition.x = rect.midX
            //MARK: Updating active tab Position
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}

struct AnimatedTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTabBar()
    }
}

enum Tabs: String, CaseIterable {
    case home = "Home"
    case services = "Services"
    case partners = "Partners"
    case activity = "Activity"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .services:
            return "envelope.open"
        case .partners:
            return "hand.raised.fingers.spread"
        case .activity:
            return "bell"
        }
    }
    
    var index: Int {
        return Tabs.allCases.firstIndex(of: self) ?? 0
    }
}

//MARK: Tab Bar Shape.
struct TabShape: Shape {
    
    var curveMidPointX: CGFloat
    
    //MARK: adding shape Animation
    var animatableData: CGFloat {
        get { curveMidPointX }
        set {
            curveMidPointX = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //MARK: First drawing the rectangle shape.
        path.addPath(Rectangle().path(in: rect))
        
        //MARK: Now drawing the upward Curve Shape.
        path.move(to: .init(x: curveMidPointX - 60, y: 0))
        
        let to = CGPoint(x: curveMidPointX, y: -25)
        let control1 = CGPoint(x: curveMidPointX - 25, y: 0)
        let control2 = CGPoint(x: curveMidPointX - 25, y: -25)
        
        path.addCurve(to: to, control1: control1, control2: control2)
        
        let to1 = CGPoint(x: curveMidPointX + 60, y: 0)
        let control3 = CGPoint(x: curveMidPointX + 25, y: -25)
        let control4 = CGPoint(x: curveMidPointX + 25, y: 0)
        
        path.addCurve(to: to1, control1: control3, control2: control4)
        
        return path
    }
    
}

//MARK: Tab Position
struct PositionKey: PreferenceKey {
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition(_ completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    
                    let rect = $0.frame(in: .global)
                    Color.clear
                        .preference(key: PositionKey.self, value: rect)
                        .onPreferenceChange(PositionKey.self, perform: completion)
                }
            }
    }
}
