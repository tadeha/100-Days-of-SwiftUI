//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/9/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ProspectsView: View {
  
  enum FilterType {
    case none, contacted, uncontacted
  }
  
  @EnvironmentObject var prospects: Prospects
  let filter: FilterType
  
  var title: String {
    switch filter {
      case .none:
        return "Everyone"
      case .contacted:
        return "Contacted people"
      case .uncontacted:
        return "Uncontacted people"
    }
  }
  
  var filteredProspects: [Prospect] {
    switch filter {
      case .none:
        return prospects.people
      case .contacted:
        return prospects.people.filter { $0.isContacted }
      case .uncontacted:
        return prospects.people.filter { !$0.isContacted }
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(filteredProspects) { prospect in
          VStack(alignment: .leading) {
            Text(prospect.name)
              .font(.headline)
            Text(prospect.emailAddress)
              .foregroundColor(.secondary)
          }
        }
      }
      .navigationBarTitle(title)
      .navigationBarItems(trailing: Button(action: {
        
        let prospect = Prospect()
        prospect.name = "Tadeh Alexani"
        prospect.emailAddress = "hi@TadehAlexani.com"
        
        self.prospects.people.append(prospect)
        
      }, label: {
        Image(systemName: "qrcode.viewfinder")
        Text("Scan")
      }))
    }
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
