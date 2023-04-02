//
//  OptimiseBuildSettings.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 02/04/23.
//

import Foundation

/*
 We can perform faster build with following changes in Build Settings.
 Goto Build Setting -> Select All -> filter Other Librarian Flags add folloeing field in it.
 1. -WLinkingC true - It says that just do not start compling in the standard way that the dependency graphs are resolved.
 2. -XCBuildForPre true -
 3. -XCExpApple true
 */
