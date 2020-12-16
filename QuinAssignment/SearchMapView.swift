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
    @State private var search = ""
    @State private var landmarks = [Landmark]()
    
    private func getNearByLandMarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            if let err = error {
                print("error local search")
                print(err.localizedDescription)
            } else if let res = response {
                let mapItems = res.mapItems
                self.landmarks = mapItems.map({ (item) -> Landmark in
                    return Landmark(placemark: item.placemark)
                })
            }
            
        }
    }
    
    var body: some View {
        ZStack(alignment : .top) {
            MapView(landmarks: self.landmarks)
                .edgesIgnoringSafeArea(.all)
            TextField("Search", text: $search) { (flag) in
                
            } onCommit: {
                print("commit")
                self.getNearByLandMarks()
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
