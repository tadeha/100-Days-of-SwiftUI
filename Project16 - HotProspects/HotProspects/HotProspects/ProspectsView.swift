//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/9/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
  
  enum FilterType {
    case none, contacted, uncontacted
  }
  
  @EnvironmentObject var prospects: Prospects
  @State private var showingScanner = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
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
          .contextMenu {
            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
              self.prospects.toggle(prospect)
            }
          }
        }
      }
      .sheet(isPresented: $showingScanner) {
        CodeScannerView(codeTypes: [.qr],simulatedData: "Tadeh Alexani\nhi@TadehAlexani.com", completion: self.handleScan)
      }
      .alert(isPresented: $showingAlert) {
        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
      }
      .navigationBarTitle(title)
      .navigationBarItems(trailing: Button(action: {
        self.showingScanner = true
      }, label: {
        Image(systemName: "qrcode.viewfinder")
        Text("Scan")
      }))
    }
  }
  
  func handleScan(result: Result<String, CodeScannerView.ScanError>) {
    showingScanner = false
    switch result {
      case .success(let code):
        let details = code.components(separatedBy: "\n")
        
        guard details.count == 2 else {
          return
        }
        
        let prospect = Prospect()
        prospect.name = details[0]
        prospect.emailAddress = details[1]
        
        self.prospects.people.append(prospect)
      
      case .failure(let error):
        self.showingAlert = true
        self.alertTitle = "Error Occured"
        self.alertMessage = error.localizedDescription
    }
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
