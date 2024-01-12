//
//  ContentView.swift
//  DragMe
//
//  Created by Tim Mitra on 2024-01-12.
//

import SwiftUI

struct ContentView: View {
  @GestureState private var dragState = DragState.inactive
  @State private var position = CGSize.zero
  var body: some View {
    VStack {
      DraggableView() {
          Image(systemName: "star.circle.fill")
              .font(.system(size: 100))
              .foregroundColor(.green)
      }
      DraggableView() {
          Text("Swift")
              .font(.system(size: 100))
              .foregroundColor(.red)
      }
      DraggableView() {
        Circle()
          .frame(width: 100, height: 100)
              .foregroundColor(.purple)
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
