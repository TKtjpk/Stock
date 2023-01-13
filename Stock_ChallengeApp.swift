//
//  Stock_ChallengeApp.swift
//  Stock Challenge
//
//  Created by MacBook Pro (Tomasz) on 11/05/2021.
//

import SwiftUI

@main
struct Stock_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(ContentModel())
        }
    }
}
