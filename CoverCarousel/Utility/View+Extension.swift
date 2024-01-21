//
//  View+Extension.swift
//  CoverCarousel
//
//  Created by Gagan Vishal  on 2024/01/19.
//

import SwiftUI

extension View {
    @ViewBuilder
    func addRefelection(_ added: Bool) -> some View {
        self
            .overlay {
                if added {
                    GeometryReader{
                        let size = $0.size
                        self
                            .scaleEffect(y: -1)
                            .mask {
                                Rectangle()
                                    .fill(
                                        .linearGradient(colors: [.white, .white.opacity(0.7), .white.opacity(0.5), .white.opacity(0.3)] + Array(repeating: Color.clear, count: 5),
                                                        startPoint: .top,
                                                        endPoint: .bottom)
                                    )
                            }
                            .offset(y: size.height)
                            .opacity(0.5)
                    }
                }
            }
    }
}

