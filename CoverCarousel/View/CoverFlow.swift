//
//  CoverFlow.swift
//  CoverCarousel
//
//  Created by Gagan Vishal  on 2024/01/19.
//

import SwiftUI

struct CoverFlow<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    
    var spacing: CGFloat
    var rotation: CGFloat
    var reflectionEnabled: Bool

    var itemWidth: CGFloat
    var items: Item
    var content: (Item.Element) -> Content
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(items) { item in
                        content(item)
                            .frame(width: itemWidth)
                            .addRefelection(reflectionEnabled)
                            .visualEffect { content, geometryProxy in
                                content
                                    .rotation3DEffect( Angle(degrees: rotation(geometryProxy: geometryProxy)), axis: (x: 0, y: 1, z: 0), anchor: .center)
                            }
                            .padding(.trailing, item.id == items.last?.id ? 0 : spacing)
                    }
                }
                // Start from center of screen
                .padding(.horizontal, (size.width - itemWidth) / 2)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
        }
    }
}

#Preview {
    ContentView()
}

private extension CoverFlow {
     func rotation(geometryProxy: GeometryProxy) -> CGFloat {
        let scrollViewWidth = geometryProxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0.0
        let midX = geometryProxy.frame(in: .scrollView(axis: .horizontal)).midX
        
        let progress = midX / scrollViewWidth
        
        let limitProress = max(min(progress, 1), 0)
        let limitRotation = max(min(rotation, 90), 0)
         
        let degree = limitProress * (limitRotation * 2)
         
        return limitRotation - degree
    }
}
