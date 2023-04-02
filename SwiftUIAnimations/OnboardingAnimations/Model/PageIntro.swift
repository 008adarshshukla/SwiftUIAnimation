//
//  PageIntro.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 02/04/23.
//

import SwiftUI

//Page Intro Model
struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displayAction: Bool = false //this indicars if the page contains actions such as login or signup.
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "Page 1", title: "Connect with\nCreators Easily", subTitle: "Thank you for choosing us, we can save your lovely time."),
    .init(introAssetImage: "Page 2", title: "Get Inspirations\nFrom Creators", subTitle: "Find your favourite creator and get inspired by them."),
    .init(introAssetImage: "Page 3", title: "Let's\nGet Started", subTitle: "To register for an account, kindly enter your details.", displayAction: true)
]
