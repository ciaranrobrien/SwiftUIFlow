/**
*  SwiftUIFlow
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct Flow<Content>: View
where Content : View
{
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                Color.clear
                    .onAppear { size = geometry.size }
                    .onChange(of: geometry.size) { size = $0 }
            }
            .frame(width: axis == .horizontal ? 0 : nil, height: axis == .vertical ? 0 : nil)
            .hidden()
            
            FlowLayout(axis: axis,
                       content: content,
                       horizontalSpacing: horizontalSpacing ?? 8,
                       size: size,
                       verticalSpacing: verticalSpacing ?? 8)
        }
    }
    
    @State private var size = CGSize.zero
    
    var axis: Axis
    var content: () -> Content
    var horizontalSpacing: CGFloat?
    var verticalSpacing: CGFloat?
}
