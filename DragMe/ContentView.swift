//
//  ContentView.swift
//  DragMe
//
//  Created by Tim Mitra on 2024-01-12.
//

import SwiftUI

struct ContentView: View {
  // for longpress
  @GestureState private var isPressed = false
  // for dragGetsure
  @GestureState private var dragOffset = CGSize.zero
  @State private var position = CGSize.zero
  var body: some View {
    VStack {
      Image(systemName: "star.circle.fill")
        .font(.largeTitle)
        .foregroundStyle(.tint)
        .animation(.easeInOut, value: 2.0)
        .opacity(isPressed ? 0.5 : 1.0)
        .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
        .gesture(
          LongPressGesture(minimumDuration: 1.0)
                          .updating($isPressed, body: { (currentState, state, transaction) in
                              state = currentState
                          })
                          .sequenced(before: DragGesture())
            .updating($dragOffset, body: { (value, state, transaction) in
              
              switch value {
              case .first(true):
                print("Tapping")
              case .second(true, let drag):
                state = drag?.translation ?? .zero
              default:
                break
              }
            })
            .onEnded({ (value) in
              guard case .second(true, let drag?) = value else { return }
              self.position.height += drag.translation.height
              self.position.width += drag.translation.width
            })
        )
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
