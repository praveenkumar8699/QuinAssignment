//
//  SavedSearchesView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 17/12/20.
//

import SwiftUI
import CoreData
import MapKit
import CoreLocation

struct SavedSearchesView: View {
    let onComplete: (Double, Double) -> Void
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
      // 2.
        entity: Location.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]
      // 3.
//      sortDescriptors: [
//        NSSortDescriptor(keyPath: \Location.title, ascending: true)
//      ]
      //,predicate: NSPredicate(format: "genre contains 'Action'")
      // 4.
    ) var savedLocations: FetchedResults<Location>
    
    var body: some View {
        VStack {
            List {
                ForEach(savedLocations, id : \.long) {
                    let name = $0.name ?? "No Name"
                    let title = $0.title ?? "No Title"
                    let lat = $0.lat
                    let long = $0.long
                    PlaceView(placeName: name, title: title)
                        .onTapGesture {
                            onComplete(lat,long)
                        }
                }
            }
        }
    }
}

/* struct SavedSearchesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedSearchesView(onComplete: <#(Double, Double) -> Void#>)
    }
} */
