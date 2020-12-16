//
//  SearchMapView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import SwiftUI
import MapKit

struct SearchMapView: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State var search = ""
    
    private func getNearByLandMarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request).start { (response, error) in
            
            if let err = error {
                print(err.localizedDescription)
            } else if let res = response {
                let mapItems = res.mapItems
            }
            
        }
    }
    
    var body: some View {
        ZStack(alignment : .top) {
            MapView()
                .edgesIgnoringSafeArea(.all)
            TextField("Search", text: $search) { (flag) in
                
            } onCommit: {
                
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())

        }
    }
}

struct SearchMapView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMapView()
    }
}
