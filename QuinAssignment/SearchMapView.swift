//
//  SearchMapView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import SwiftUI
import MapKit
import CoreData

struct SearchMapView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var auth : Auth
    @ObservedObject var locationManager = LocationManager()
    @State private var search = ""
    @State private var landmarks = [Landmark]()
    @State private var destination : MKPlacemark? = nil
    @State var isPresented = false
    @FetchRequest(
        // 2.
        entity: Location.entity(), sortDescriptors: []
        // 3.
        //      sortDescriptors: [
        //        NSSortDescriptor(keyPath: \Location.title, ascending: true)
        //      ]
        //,predicate: NSPredicate(format: "genre contains 'Action'")
        // 4.
    ) var savedLocations: FetchedResults<Location>
    
    private func getNearByLandMarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            if let err = error {
                print("error local search")
                print(err.localizedDescription)
                self.landmarks.removeAll()
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
            
            let binding = Binding<String>(get: {
                self.search
            }, set: {
                self.search = $0
                self.getNearByLandMarks()
            })
            
            MapView(destination: self.destination)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Button(action : {
                    auth.loggedIn = false
                    Defaults.isLoggedIn = false
                }) {
                    Text("Logout")
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                Spacer()
                Button(action : {
                    self.isPresented = true
                }) {
                    Text("Saved Places")
                        .sheet(isPresented: $isPresented, content: {
                            SavedSearchesView { (lat, long) in
                                let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long)))
                                self.destination = placemark
                                self.isPresented = false
                            }.environment(\.managedObjectContext, self.managedObjectContext)
                        })
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
            }
            
            HStack {
                
                TextField("Search", text: binding) { (flag) in
                    
                } onCommit: {
                    print("commit")
                    self.getNearByLandMarks()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                Button(action : {
                    self.search.removeAll()
                    self.landmarks.removeAll()
                    self.destination = nil
                }){
                    Image(systemName: "xmark.circle.fill")
                }
            }
            //            .frame(height : 50)
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
            .background(Color.clear)
            .cornerRadius(5)
            
            
            if landmarks.isEmpty {
                EmptyView()
            } else {
                List(self.landmarks) { landmark in
                    HStack {
                        PlaceView(placeName: landmark.name, title: landmark.title)
                    }
                    .onTapGesture {
                        self.destination = landmark.placemark
                        saveLocation(lat: landmark.coordinate.latitude, long: landmark.coordinate.longitude, title: landmark.title, name: landmark.name)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                .frame(width : UIScreen.main.bounds.width, height: 250)
                .offset(y: 50)
            }
            
        }
        .navigationBarHidden(true)
    }
    
    
    func saveLocation(lat: Double, long: Double, title : String, name : String) {
        // 1
        let newLoc = Location(context: managedObjectContext)
        
        newLoc.date = Date()
        newLoc.lat = lat
        newLoc.long = long
        newLoc.title = title
        newLoc.name = name
        
        DataManager.saveContext()
    }
}



struct SearchMapView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMapView()
    }
}
