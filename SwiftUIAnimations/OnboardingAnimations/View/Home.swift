//
//  Home.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 02/04/23.
//

import SwiftUI

struct Home: View {
    
    @State private var activeIntro: PageIntro = pageIntros[0]
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            IntroView(intro: $activeIntro, size: size)
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

/// Intro View
struct IntroView: View {
    
    @Binding var intro: PageIntro
    var size: CGSize
    
    var body: some View {
        VStack {
            GeometryReader {
                let size = $0.size
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
            }
            
            ///Tile and Actions.
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                Text(intro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                Text(intro.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 15)
                
                if !intro.displayAction {
                    Group {
                        Spacer()
                        CustomIndicatorView(totalPages: pageIntros.count, currentPage: pageIntros.firstIndex(of: intro) ?? 0)
                    }
                } else {
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
