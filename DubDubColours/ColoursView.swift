//
//  ContentView.swift
//  DubDubColours
//
//  Created by Derek Wang on 2022-06-09.
//

import SwiftUI

struct ColoursView: View {
    
    @State private var location = CGPoint()
    @State private var useBold = false
    @State private var useItalic = false
    @State private var diameter = 150.0
    
    let displayTexts: [String] = [
        "Hello, Apple Park 🍎",
        "Hello, WWDC22 😎",
        "Hello, Infinite Loop 🥰",
        "Hello, New Developer's Centre 🏢",
        "Hello, SwiftUI 4 💪",
        "Hello, iOS 16 📱",
        "Hello, New CarPlay 🚗",
        "Hello, Midnight M2 MacBook Air 💻",
        "Hello, SwiftUI Charts 📊",
        "Hello, iPadOS 16 🥳",
        "Hello, watchOS 9 ⌚️"
    ]
    
    @State private var offset = CGSize.zero
    @State private var index = 0
    
    @State private var colours: [Color] = [
        .init("base"),
        .init("green"),
        .init("peach"),
        .init("orange")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: colours,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text(displayTexts[index])
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .font(.title)
                    .bold(useBold)
                    .italic(useItalic)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                offset = gesture.translation
                            }
                            .onEnded { _ in
                                withAnimation(.interpolatingSpring(stiffness: 20, damping: 7)) {
                                    offset = .zero
                                }
                            }
                    )
                
                Spacer()
                
                
                Button {
                    withAnimation {
                        colours.shuffle()
                    }
                    animateText()
                    animateButton()
                    
                } label: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 1)
                            .frame(width: diameter, height: diameter)
                            .background(.ultraThinMaterial, in: Circle())
                        Circle()
                            .strokeBorder(.white, lineWidth: 1)
                            .frame(width: 80, height: 80)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    
                }
            }
        }
    }
    
    func animateText() {
        withAnimation {
            if index < displayTexts.count - 1 {
                index += 1
            } else {
                index = 0
            }
        }
        
        withAnimation(.easeInOut) {
            useBold.toggle()
            useItalic.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeInOut) {
                useBold.toggle()
                useItalic.toggle()
            }
        }
    }
    
    func animateButton() {
        withAnimation(.easeInOut) {
            diameter = 100
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut) {
                diameter = 150
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColoursView()
    }
}
