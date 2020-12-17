//
//  PlaceView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import SwiftUI

struct PlaceView: View {
    let placeName : String
    let title : String
    var body: some View {
        VStack(alignment : .leading) {
            Text("\(placeName)")
                .font(.title)
            Text("\(title)")
                .font(.footnote)
        }
        .padding()
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(placeName: "Place Name", title: "Title")
    }
}
