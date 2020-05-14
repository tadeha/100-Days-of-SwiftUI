//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Tadeh Alexani on 5/14/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct EmojiRatingView: View {
  
  var rating: Int16
  
  var body: some View {
    switch rating {
      case 1:
        return Text("😟")
      case 2:
        return Text("😕")
      case 3:
        return Text("🙂")
      case 4:
        return Text("😄")
      default:
        return Text("🤩")
    }
  }
}

struct EmojiRatingView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiRatingView(rating: 3)
  }
}
