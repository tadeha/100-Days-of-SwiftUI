//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/26/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

// Views can be given a height of 0.
// This is helpful to make spacers work only in a single direction.

// If we place views inside a Group the parent view decides how those views should be laid out.
// This happens because Group is layout neutral.

import SwiftUI

enum SortingType {
  case none
  case alphabetical
  case country
}

struct ContentView: View {
  
  @ObservedObject var favorites = Favorites()
  let resorts: [Resort] = Bundle.main.decode("resorts.json")
  
  @State private var countryForFiltering = "All"
  @State private var sizeForFiltering = 0
  @State private var priceForFiltering = 0
  
  @State private var sortingType = SortingType.none
  
  var sortedResorts: [Resort] {
    switch sortingType {
      case .none:
        return resorts
      case .alphabetical:
        return resorts.sorted { (firstResort, secondResort) -> Bool in
          firstResort.name < secondResort.name
      }
      case .country:
        return resorts.sorted { (firstResort, secondResort) -> Bool in
          firstResort.country > secondResort.country
      }
    }
  }
  
  //MARK: Day 99. Challenge 3.4
  var filteredResorts: [Resort] {
    var tempResorts = sortedResorts
    
    tempResorts = tempResorts.filter { (resort) -> Bool in
      resort.country == self.countryForFiltering || self.countryForFiltering == "All"
    }
    
    tempResorts = tempResorts.filter { (resort) -> Bool in
      resort.size == self.sizeForFiltering || self.sizeForFiltering == 0
    }
    
    tempResorts = tempResorts.filter { (resort) -> Bool in
      resort.price == self.priceForFiltering || self.priceForFiltering == 0
    }
    
    return tempResorts
  }
  
  //MARK: Day 99. Challenge 3.5
  @State private var isShowingSortingSheet = false
  @State private var isShowingFilteringSheet = false
  
  var body: some View {
    NavigationView {
      List(filteredResorts) { resort in
        NavigationLink(destination: ResortView(resort: resort) ) {
          Image(resort.country)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 25)
            .clipShape(
              RoundedRectangle(cornerRadius: 5)
          )
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 1)
          )
          
          VStack(alignment: .leading) {
            Text(resort.name)
              .font(.headline)
            Text("\(resort.runs) runs")
              .foregroundColor(.secondary)
          }
          .layoutPriority(1)
          
          if self.favorites.contains(resort) {
            Spacer()
            Image(systemName: "heart.fill")
              .foregroundColor(.red)
              .accessibility(label: Text("This is a favorite resort"))
          }
        }
      }
      .navigationBarTitle("Resorts")
      .navigationBarItems(leading: Button(action: {
        self.isShowingFilteringSheet.toggle()
      }, label: {
        Text("Filter")
      }), trailing: Button(action: {
        self.isShowingSortingSheet.toggle()
      }, label: {
        Text("Sort")
      }))
      .sheet(isPresented: $isShowingFilteringSheet) {
        FilteringView(countryForFiltering: self.$countryForFiltering, sizeForFiltering: self.$sizeForFiltering, priceForFiltering: self.$priceForFiltering)
      }
      .actionSheet(isPresented: $isShowingSortingSheet) { () -> ActionSheet in
        ActionSheet(title: Text("Choose your sort option:"), message: nil, buttons: [.default(Text("Alphabetical"), action: {
          self.sortingType = .alphabetical
        }), .default(Text("By Country"), action: {
          self.sortingType = .country
        }), .default(Text("Default"), action: {
          self.sortingType = .none
        }), .cancel()])
      }
      
      WelcomeView()
    }
    .environmentObject(favorites)
    // .phoneOnlyStackNavigationView()
  }
  
  
}

extension View {
  func phoneOnlyStackNavigationView() -> some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
    } else {
      return AnyView(self)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(Favorites())
  }
}
