//
//  ContentView.swift
//  DragMe
//
//  Created by Tim Mitra on 2024-01-12.
//

import SwiftUI

struct ContentView: View {
  @State private var isPressed = false
  @GestureState private var longPressTap = false
  var body: some View {
    VStack {
      Image(systemName: "star.circle.fill")
        .font(.largeTitle)
        .foregroundStyle(.tint)
        .opacity(longPressTap ? 0.4 : 1.0)
        .scaleEffect(isPressed ? 2.5 : 1.0)
        .animation(.easeInOut, value: 2.0)
        .gesture(
          LongPressGesture(minimumDuration: 1.0)
            .updating($longPressTap, body: { (currentState, state, transaction) in
                            state = currentState
                        })
            .onEnded({ _ in
              self.isPressed.toggle()
            })
        )
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
