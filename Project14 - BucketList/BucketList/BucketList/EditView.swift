//
//  EditView.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/29/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
  enum LoadingState {
    case loading, loaded, failed
  }
  
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var placemark: MKPointAnnotation
  @State private var loadingState = LoadingState.loading
  @State private var pages = [Page]()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Place Title", text: $placemark.wrappedTitle)
          TextField("Description", text: $placemark.wrappedDescription)
        }
        Section(header: Text("Nearby Places")) {
          if self.loadingState == .loaded {
            List(pages, id: \.pageid) { page in
              Text(page.title)
                .font(.headline) + Text(": ") +
                Text(page.description)
                  .italic()
            }
          } else if self.loadingState == .loading {
            Text("Loading..")
          } else {
            Text("Please try again later.")
          }
          
        }
      }
      .navigationBarTitle("Edit Place")
      .navigationBarItems(trailing: Button("Done") {
        self.presentationMode.wrappedValue.dismiss()
      })
        .onAppear(perform: fetchNearbyPlaces)
    }
  }
  
  func fetchNearbyPlaces() {
    let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
    
    guard let url = URL(string: urlString) else {
      print("Bad URL: \(urlString)")
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      
      if let data = data {
        
        let decoder = JSONDecoder()
        
        if let items = try? decoder.decode(Result.self, from: data) {
          self.pages = Array(items.query.pages.values).sorted()
          self.loadingState = .loaded
          return
        }
        
      }
      
      self.loadingState = .failed
    }.resume()
  }
}

struct EditView_Previews: PreviewProvider {
  static var previews: some View {
    EditView(placemark: MKPointAnnotation.example)
  }
}
