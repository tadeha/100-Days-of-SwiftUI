//
//  Training_ContentView.swift
//  Bookworm
//
//  Created by Tadeh Alexani on 5/13/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct PushButton: View {
  let title: String
  @Binding var isOn: Bool
  
  var onColors = [Color.red, Color.yellow]
  var offColors = [Color(white: 0.6), Color(white: 0.4)]
  
  var body: some View {
    Button(title) {
      self.isOn.toggle()
    }
    .padding()
    .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
    .foregroundColor(.white)
    .clipShape(Capsule())
    .shadow(radius: isOn ? 0 : 5)
    
  }
  
}

struct Training_ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
  
  var body: some View {
    VStack {
      List() {
        ForEach(students, id: \.id) { student in
          Text(student.name ?? "Unknown")
        }
      }
      Button("Add") {
        let firstNames = ["Tadeh","Mehrnoosh","Farokh","Hasan"]
        let lastNames = ["Shahabi","Noori","Baratopour","Alexani"]
        
        let chosenFirstName = firstNames.randomElement()!
        let chosenLastName = lastNames.randomElement()!
        
        let student = Student(context: self.moc)
        student.id = UUID()
        student.name = "\(chosenFirstName) \(chosenLastName)"
        
        try? self.moc.save()
      }
    }
  }
}

struct Training_ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Training_ContentView()
  }
}

