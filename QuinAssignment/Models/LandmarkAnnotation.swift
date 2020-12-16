//
//  LandmarkAnnotation.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import MapKit

class LandmarkAnnotation : NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark : Landmark) {
        title = landmark.title
        coordinate = landmark.coordinate
    }
    
}
