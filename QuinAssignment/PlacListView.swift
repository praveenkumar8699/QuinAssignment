//
//  PlacListView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import SwiftUI
import MapKit

struct PlacListView: View {
    
    let landmarks : [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            
        }
    }
}

struct PlacListView_Previews: PreviewProvider {
    static var previews: some View {
        let one = Landmark(placemark: MKPlacemark())
        PlacListView(landmarks: [one])
    }
}
