//
//  LocationManager.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import MapKit

class LocationManager : NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location : CLLocation? = nil
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let local_location = locations.last else { return }
        
        self.location = local_location
    }
    
}
