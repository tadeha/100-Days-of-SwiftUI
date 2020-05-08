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
  @State private var showingAddActivity = false
  
  var body: some View {
    NavigationView {
      List() {
        ForEach(activities.items) { activity in
          NavigationLink(destination: Text("Test")) {
            HStack {
              Text(activity.title)
            }
          }
        }
      }
    .navigationBarTitle("HabitTracker")
    .navigationBarItems(trailing: Button(action: {
        self.showingAddActivity = true
      }, label: {
        Image(systemName: "plus")
      }))
    .sheet(isPresented: $showingAddActivity) {
      AddView(activities: self.activities)
    }
    }
  }
}

struct ActivitiesView_Previews: PreviewProvider {
  static var previews: some View {
    ActivitiesView()
  }
}
