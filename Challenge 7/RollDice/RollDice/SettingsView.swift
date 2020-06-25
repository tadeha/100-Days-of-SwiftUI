//
//  SettingsView.swift
//  RollDice
//
//  Created by Tadeh Alexani on 6/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  
  let sides = [4, 6, 8, 10, 12, 20, 100]
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var settings: UserSettings
  @State private var selectedSideOption = 1
  
  var body: some View {
    NavigationView {
      Form {
        Picker(selection: $selectedSideOption, label: Text("Select Dice Sides Number")) {
          ForEach(0..<self.sides.count) { index in
            Text("\(self.sides[index])-sided")
          }
        }
      }
      .navigationBarTitle("Settings", displayMode: .inline)
      .navigationBarItems(trailing: Button(action: {
        self.settings.diceSides = self.sides[self.selectedSideOption]
        self.dismiss()
      }, label: {
        Text("Save")
      }))
    }
    .onAppear(perform: setSelectedSideOptionInitialValue)
  }
  
  func setSelectedSideOptionInitialValue() {
    selectedSideOption = sides.firstIndex(of: settings.diceSides) ?? 1
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
