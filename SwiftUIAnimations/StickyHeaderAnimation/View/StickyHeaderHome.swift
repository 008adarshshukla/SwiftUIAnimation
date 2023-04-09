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
    @State private var productBasedOnType: [[Product]] = []
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                //LazyVStack for pinning the Views at the top while Scrolling
                LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                    Section {
                        //getiing an array of products of ecah types.
                        ForEach(productBasedOnType, id: \.self) { products in
                            if !products.isEmpty {
                                ProductSectionView(products)
                            }
                        }
                    } header: {
                        scrollableTabs(proxy: proxy)
                    }

                }
            }
        }
        .coordinateSpace(name: "CONTENTVIEW")
        .navigationTitle("Apple Store")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.purple, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .background {
            //gives background color to the scroll view
            Rectangle()
                .fill(Color(uiColor: .secondarySystemBackground))
                .ignoresSafeArea()
        }
        .onAppear {
            //Filtering products based on the types.(only once)
            //we proceed only when the array is empty.
            guard productBasedOnType.isEmpty else {
                return
            }
            
            //for all the cases in Product type we filter the the Products.
            for type in ProductType.allCases {
                let products = products.filter { $0.type == type }
                productBasedOnType.append(products)
            }
        }
    }
    
    @ViewBuilder
    func ProductSectionView(_ products: [Product]) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            //getting the type of the products from the its first product
            if let firstProduct = products.first {
                Text(firstProduct.type.rawValue)
                    .font(.title)
                    .fontWeight(.semibold)
                
            }
            
            ForEach(products) { product in
                productRowView(product)
            }
        }
        .padding(15)
        .id(products.first!.type)
        .Offset("CONTENTVIEW") { rect in
            let minY = rect.minY
            //When the Content reaches the top then updating the currwnt active tab.
            //Note - When the offset is between 30 and (mid - height / 2) then we are setting it as the current active tab.
            
            if (minY < 30 && -minY < (rect.midY / 2) && activeTab != products.first!.type) {
                withAnimation(Animation.easeInOut(duration: 0.3)) {
                    activeTab = (minY < 30 && -minY < (rect.midY / 2) && activeTab != products.first!.type) ? products.first!.type : activeTab
                }
            }
        }
    }
    
    @ViewBuilder
    func productRowView(_ product: Product) -> some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.title3)
                
                Text(product.subtitle)
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Text(product.price)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //Scrollable tabs
    @ViewBuilder
    func scrollableTabs(proxy: ScrollViewProxy) -> some View {
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
                                proxy.scrollTo(type, anchor: .topLeading)
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
