//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/9/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

// Encapsulation limits how much external objects can read and write values inside a class or a struct.

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
  
  enum FilterType {
    case none, contacted, uncontacted
  }
  
  @EnvironmentObject var prospects: Prospects
  @State private var showingScanner = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  @State private var showingActionSheet = false
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
          HStack {
            if self.filter == .none {
              prospect.isContacted ? Image(systemName: "person.crop.circle.badge.checkmark").foregroundColor(.green) : Image(systemName: "person.crop.circle.badge.xmark").foregroundColor(.red)
            }
            VStack(alignment: .leading) {
              Text(prospect.name)
                .font(.headline)
              Text(prospect.emailAddress)
                .foregroundColor(.secondary)
            }
          }
          .contextMenu {
            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
              self.prospects.toggle(prospect)
            }
            
            if !prospect.isContacted {
              Button("Remind Me") {
                self.addNotification(for: prospect)
              }
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
      .actionSheet(isPresented: $showingActionSheet) {
        ActionSheet(title: Text("Choose your sort option:"), buttons: [
          .default(Text("By Name")) { self.prospects.sort(by: .name) },
          .default(Text("Most Recent")) { self.prospects.sort(by: .mostRecent) },
          .cancel()
        ])
      }
      .navigationBarTitle(title)
      .navigationBarItems(leading:
        Button("Sort") {
          self.showingActionSheet = true
        }
        ,trailing: Button(action: {
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
        
        self.prospects.add(prospect)
      
      case .failure(let error):
        self.showingAlert = true
        self.alertTitle = "Error Occured"
        self.alertMessage = error.localizedDescription
    }
  }
  
  func addNotification(for prospect: Prospect) {
    
    let center = UNUserNotificationCenter.current()
    
    let addRequest = {
      
      let content = UNMutableNotificationContent()
      content.title = "Contact \(prospect.name)"
      content.subtitle = prospect.emailAddress
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
      
      let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
      
      center.add(request)
      
    }
    
    center.getNotificationSettings { settings in
      if settings.authorizationStatus == .authorized {
        addRequest()
      } else {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
          if success {
            addRequest()
          } else if let error = error {
            self.alertTitle = "Error Occured"
            self.alertMessage = error.localizedDescription
          }
        }
      }
    }
    
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
  }
}
