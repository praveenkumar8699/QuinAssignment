//
//  File.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import MapKit

struct Landmark {
    
    let placemark : MKPlacemark
    
    var id : UUID {
        return UUID()
    }
    
    var nmae : String {
        return placemark.name ?? ""
    }
    
    var title : String {
        return placemark.title ?? ""
    }
    
    var coordinate : CLLocationCoordinate2D {
        return placemark.coordinate
    }
    
}
