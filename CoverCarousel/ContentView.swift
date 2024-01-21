//
//  ContentView.swift
//  CoverCarousel
//
//  Created by Gagan Vishal  on 2024/01/19.
//

import SwiftUI

struct ContentView: View {
    private var items: [CoverFlowItem] = [.init(color: .red), .init(color: .blue), .init(color: .purple), .init(color: .green), .init(color: .yellow), .init(color: .teal), .init(color: .indigo)]
    
    @State private var spacing: CGFloat = 0
    @State private var rotation: CGFloat = 0
    @State private var isReflectionEnabled: Bool = false
    let spacingConst: CGFloat = 50
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 0)
                CoverFlow(spacing: spacing,
                          rotation: rotation,
                          reflectionEnabled: isReflectionEnabled,
                          itemWidth: UIScreen.main.bounds.width - spacingConst*3,
                          items: items) { element in
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(element.color.gradient)
                }
                .frame(height: (UIScreen.main.bounds.width - spacingConst*2)/2)
                Spacer(minLength: 0)
                VStack(alignment: .leading, spacing: 16) {
                    Group {
                        Toggle("Enable Reflection", isOn: $isReflectionEnabled)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Card Spacing")
                            Slider(value: $spacing, in: -90...20)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Card rotation")
                            Slider(value: $rotation, in: 0...180)
                        }
                    }
                    .padding(10)
                }
                .padding([.horizontal, .bottom], 16.0)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 20))
            }
            .navigationTitle("Cover Carousel Flow")
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
