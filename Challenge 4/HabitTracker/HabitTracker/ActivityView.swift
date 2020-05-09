//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Tadeh Alexani on 5/8/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
  
  @ObservedObject var activities: Activities
  @State var activity: Activity
  
  var body: some View {
    VStack(alignment: .center, spacing: 32) {
        Text(activity.title)
            .font(.system(size: 50, weight: .bold))
            .multilineTextAlignment(.center)
        Text(activity.description)
            .font(.system(size: 30))
        .multilineTextAlignment(.center)
        Text("\(activity.completionCount)")
            .font(.system(size: 35))
        Stepper("Completion Count", onIncrement: {
            self.activity.completionCount += 1
            self.saveActivity()
        }, onDecrement: {
            self.activity.completionCount -= 1
            self.saveActivity()
        })
        .labelsHidden()
        Spacer()
    }
    .padding()
  }
  
  func saveActivity() {
      guard let index = activities.items.firstIndex(where: {$0.id == activity.id }) else { return }
      activities.items[index].completionCount = activity.completionCount
  }
}

