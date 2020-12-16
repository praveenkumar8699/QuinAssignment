//
//  MapView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import MapKit
import SwiftUI

class Coordinator : NSObject,MKMapViewDelegate {
    
    var control : MapView
    
    init(_ control : MapView) {
        self.control = control
    }
    
//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
//        if let annotationView = views.first {
//            if let annotaion = annotationView.annotation {
//                let region = MKCoordinateRegion(center: annotaion.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
//                mapView.setRegion(region, animated: true)
//            }
//        }
//    }
    
}

struct MapView : UIViewRepresentable {
    
    let landmarks : [Landmark]
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        updateAnnotaions(from: uiView)
    }
    
    private func updateAnnotaions(from mapView : MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map { (landmark) -> LandmarkAnnotation in
            return LandmarkAnnotation(landmark: landmark)
        }
        mapView.addAnnotations(annotations)
    }
    
}
