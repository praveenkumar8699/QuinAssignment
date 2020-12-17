//
//  MapView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import MapKit
import SwiftUI
import CoreLocation
import CoreGraphics


class Coordinator : NSObject,MKMapViewDelegate {
    
    var control : MapView
    
    init(_ control : MapView) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first {
            if let annotaion = annotationView.annotation {
                let region = MKCoordinateRegion(center: annotaion.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let renderer = MKPolylineRenderer(overlay: overlay)

        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)

        renderer.lineWidth = 5.0

        return renderer
    }
    
}

struct MapView : UIViewRepresentable {
    
    //    let landmarks : [Landmark]
    var destination : MKPlacemark?
    
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
        
        drawDirection(for: uiView)
        //        updateAnnotaions(from: uiView)
        
    }
    
    
    private func drawDirection(for mapView : MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        if let loc_destination = destination {
            
            let currentPlacemark = MKPlacemark(coordinate: mapView.userLocation.coordinate)
            
            let sourceAnnotation = MKPointAnnotation()
            
            if let location = currentPlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            let destinationAnnotation = MKPointAnnotation()
            
            if let location = loc_destination.location {
                destinationAnnotation.coordinate = location.coordinate
            }
            
            mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: currentPlacemark)
            request.destination = MKMapItem(placemark: loc_destination)
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
//            let padding: CGFloat = 8
            directions.calculate { (response, error) in
                
                if let err = error {
                    print(err.localizedDescription)
                } else if let first = response?.routes.first {
                    
                    mapView.addOverlay(first.polyline, level: .aboveRoads)
                    let rect = first.polyline.boundingMapRect
                    mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                }
                
            }
        } else {
            mapView.removeOverlays(mapView.overlays)
            mapView.removeAnnotations(mapView.annotations)
        }
        
    }
    
    private func updateAnnotaions(from mapView : MKMapView) {
        
    }
    
}
