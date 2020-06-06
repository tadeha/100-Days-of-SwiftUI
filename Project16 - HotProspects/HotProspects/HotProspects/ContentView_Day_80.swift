//
//  ContentView_Day_80.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/5/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

enum NetworkError: Error {
  case badURL, requestFailed, unknown
}

class DelayUpdater: ObservableObject {
  var value = 0 {
    willSet {
      objectWillChange.send()
    }
  }
  
  init() {
    for i in 1...10 {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
        self.value += 1
      }
    }
  }
}

struct ContentView_Day_80: View {
  
  @ObservedObject var updater = DelayUpdater()
  
  var body: some View {
    
    VStack {
      Image("example")
        .interpolation(.none)
        .resizable()
        .scaledToFit()
        .frame(maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
      
      Text("Value is \(updater.value)")
        .onAppear {
          self.fetchData(from: "https://www.apple.com") { result in
            switch result {
              case .success(let str):
                print(str)
              case .failure(let error):
                switch error {
                  case .badURL:
                    print("Bad URL")
                  case .requestFailed:
                    print("Network problems")
                  case .unknown:
                    print("Unknown error")
              }
            }
          }
      }
    }
  }
  
  func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(.failure(.badURL))
      return
    }
    URLSession.shared.dataTask(with: url) {
      data, response, error in
      DispatchQueue.main.async {
        if let data = data {
          let stringData = String(decoding: data, as: UTF8.self)
          completion(.success(stringData))
        } else if error != nil {
          completion(.failure(.requestFailed))
        } else {
          completion(.failure(.unknown))
        }
      }
    }.resume()
  }
}

struct ContentView_Day_80_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Day_80()
  }
}
