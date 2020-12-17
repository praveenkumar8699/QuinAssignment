//
//  LandingView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 17/12/20.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var auth : Auth
    var body: some View {
        if auth.loggedIn {
            SearchMapView().environment(\.managedObjectContext, managedObjectContext)
                .environmentObject(auth)
        } else {
            LoginView().environment(\.managedObjectContext, managedObjectContext)
                .environmentObject(auth)
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
