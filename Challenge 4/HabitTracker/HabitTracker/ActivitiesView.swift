//
//  ActivitiesView.swift
//  HabitTracker
//
//  Created by Tadeh Alexani on 5/8/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ActivitiesView: View {
  
  @ObservedObject var activities = Activities()
  @Environment(\.presentationMode) var presentationMode
  @State private var showingAddActivity = false
  
  var body: some View {
    NavigationView {
      List() {
        ForEach(activities.items) { activity in
          NavigationLink(destination: ActivityView(activities: self.activities, activity: activity)) {
            HStack {
              Text(activity.title)
            }
          }
        }
      .onDelete(perform: removeItems)
      }
      .navigationBarTitle("HabitTracker")
      .navigationBarItems(leading: EditButton(), trailing:
        
        Button(action: {
          self.showingAddActivity = true
        }, label: {
          Image(systemName: "plus")
        })
      )
        .sheet(isPresented: $showingAddActivity) {
          AddView(activities: self.activities)
      }
    }
  }
  
  func removeItems(at offsets: IndexSet) {
    activities.items.remove(atOffsets: offsets)
    activities.items = activities.items
  }
}

struct ActivitiesView_Previews: PreviewProvider {
  static var previews: some View {
    ActivitiesView(activities: Activities())
  }
}
