//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Tadeh Alexani on 6/21/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var settings: UserSettings
  
  var body: some View {
    NavigationView {
      List {
        Section {
          HStack {
            Text("Stop removing cards when you swipe wrong?")
            Spacer()
            Toggle("Toggle Removing Wrong Cards", isOn: $settings.stopRemovingCards)
            .labelsHidden()
          }
        }
      }
      .navigationBarTitle("Settings")
      .navigationBarItems(trailing: Button("Done", action: dismiss))
      .listStyle(GroupedListStyle())
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
  func dismiss() {
    presentationMode.wrappedValue.dismiss()
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView().environmentObject(UserSettings())
  }
}
