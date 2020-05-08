//
//  AddView.swift
//  HabitTracker
//
//  Created by Tadeh Alexani on 5/8/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct AddView: View {
  
  @Environment(\.presentationMode) var presentationMode
  
  @ObservedObject var activities: Activities
  @State private var title = ""
  @State private var description = ""
  
  @State private var showingAlert = false
  
  var body: some View {
    
    NavigationView {
      Form {
        Section {
          TextField("Your Activity Name", text: $title)
          TextField("Your Activity Description", text: $description)
        }
      }
        
      .navigationBarTitle("Add new activity")
        
      .navigationBarItems(trailing: Button(action: {
        if self.title != "" {
          let item = Activity(title: self.title, description: self.description)
          self.activities.items.append(item)
          self.presentationMode.wrappedValue.dismiss()
        } else {
          self.showingAlert = true
        }
      }, label: {
        Text("Save")
      }))
        
      .alert(isPresented: $showingAlert) {
          Alert(title: Text("Title Error"), message: Text("Please enter a title for your activity"), dismissButton: .default(Text("OK")))
      }
      
    }
    
  }
}

struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    AddView(activities: Activities())
  }
}
