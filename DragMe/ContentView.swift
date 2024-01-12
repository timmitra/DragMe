//
//  ContentView.swift
//  DragMe
//
//  Created by Tim Mitra on 2024-01-12.
//

import SwiftUI

enum DragState {
  case inactive
  case pressing
  case dragging(translation: CGSize)
  
  var translation: CGSize {
    switch self {
    case .inactive, .pressing:
      return .zero
    case .dragging(let translation):
      return translation
    }
  }
  
  var isPressing: Bool {
    switch self {
    case .pressing, .dragging:
      return true
    case .inactive:
      return false
    }
  }
}

struct ContentView: View {
  @GestureState private var dragState = DragState.inactive
  @State private var position = CGSize.zero
  var body: some View {
    VStack {
      Image(systemName: "star.circle.fill")
        .font(.largeTitle)
        .foregroundStyle(.tint)
        .animation(.easeInOut, value: 2.0)
        .opacity(dragState.isPressing ? 0.5 : 1.0)
        .offset(x: position.width + dragState.translation.width, y: position.height + dragState.translation.height)
        .gesture(
          LongPressGesture(minimumDuration: 1.0)
            .sequenced(before: DragGesture())
            .updating($dragState, body: { (value, state, transaction) in
              
              switch value {
              case .first(true):
                state = .pressing
              case .second(true, let drag):
                state = .dragging(translation: drag?.translation ?? .zero)
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
