//
//  ContentView.swift
//  CatchUp
//
//  Created by Tadeh Alexani on 6/3/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var images = [CodableImage]()
  @State private var showingSheet = false
  
  var body: some View {
    NavigationView {
      Group {
        if images.count != 0 {
          List(images, id: \.id) { image in
            NavigationLink(destination: DetailView(codableImage: image)) {
              HStack {
                if UIImage(data: image.jpegData) != nil {
                  Image(uiImage: UIImage(data: image.jpegData)!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .frame(width: 85)
                    .padding([.vertical])
                }
                Text("Name:")
                  .fontWeight(.bold)
                Text(image.name)
              }
            }
          }
        } else {
          VStack {
            Text("No Images Found.")
              .fontWeight(.bold)
            Text("Please add one using the + button above.")
              .foregroundColor(.secondary)
          }
          
        }
      }
      .navigationBarTitle("Catch Up")
      .navigationBarItems(trailing: Button(action: {
        self.showingSheet = true
      }, label: {
        Image(systemName: "plus")
      }))
    }
    .sheet(isPresented: $showingSheet, onDismiss: loadData) {
      AddView(images: self.images)
    }
    .onAppear(perform: loadData)
    
  }
  
  func loadData() {
    let filename = FileManager.getDocumentsDirectory().appendingPathComponent("SavedPhotos")
    
    do {
      let data = try Data(contentsOf: filename)
      images = try JSONDecoder().decode([CodableImage].self, from: data).sorted()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
