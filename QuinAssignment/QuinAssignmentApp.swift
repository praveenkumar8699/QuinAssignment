//
//  QuinAssignmentApp.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import SwiftUI

@main
struct QuinAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if Defaults.isLoggedIn {
                    SearchMapView()
                } else {
                    LoginView()
                }
            }
        }
    }
}
