//
//  QuinAssignmentApp.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import SwiftUI
import CoreData

@main
struct QuinAssignmentApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @StateObject var auth = Auth()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LandingView().environment(\.managedObjectContext, DataManager.persistentContainer.viewContext)
                    .environmentObject(auth)
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
                DataManager.saveContext()
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
                DataManager.saveContext()
            }
        }
    }
}
