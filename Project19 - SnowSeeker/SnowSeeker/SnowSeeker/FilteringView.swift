//
//  FilteringView.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/29/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct FilteringView: View {
  @Environment(\.presentationMode) var presentationMode
  
  let countriesArray = ["All", "USA", "Italy", "France", "Canada", "Austria"]
  let sizesArray = ["All", "Small", "Average", "Large"]
  let pricesArray = ["All", "$", "$$", "$$$"]
  
  @Binding var countryForFiltering: String
  @Binding var sizeForFiltering: Int
  @Binding var priceForFiltering: Int
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Select country for filtering: ")) {
          Picker(selection: $countryForFiltering, label: Text("Select country for filtering: ")) {
            ForEach(countriesArray, id: \.self) { country in
              Text("\(country)")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        Section(header: Text("Select size for filtering")) {
          Picker(selection: $sizeForFiltering
          , label: Text("Select size for filtering")) {
            ForEach(0 ..< self.sizesArray.count) { number in
              Text("\(self.sizesArray[number])")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        Section(header: Text("Select price for filtering: ")) {
          Picker(selection: $priceForFiltering, label: Text("Select price for filtering")) {
            ForEach(0 ..< self.pricesArray.count){ number in
              Text("\(self.pricesArray[number])")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
      }
      .navigationBarTitle(Text("Filter"), displayMode: .inline)
      .navigationBarItems(trailing: Button(action: {
        self.dismiss()
      }, label: {
        Text("Done")
      }))
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}

//struct FilteringView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteringView()
//    }
//}
