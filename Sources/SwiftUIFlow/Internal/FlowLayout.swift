/**
*  SwiftUIFlow
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct FlowLayout<Content>: View
where Content : View
{
    var axis: Axis
    var content: () -> Content
    var horizontalSpacing: CGFloat
    var size: CGSize
    var verticalSpacing: CGFloat
    
    var body: some View {
        var leading: CGFloat = 0
        var top: CGFloat = 0
        var nextTop: CGFloat = 0
        var maxValue: CGFloat = 0
        
        content()
            .frame(maxWidth: axis == .vertical ? size.width : nil,
                   maxHeight: axis == .horizontal ? size.height : nil,
                   alignment: .topLeading)
            .fixedSize()
            .alignmentGuide(.leading) { dimensions in
                switch axis {
                case .horizontal:
                    if (abs(top - dimensions.height) > size.height) {
                        leading -= (top == 0 ? dimensions.width : maxValue) + horizontalSpacing
                        top = 0
                        maxValue = dimensions.width
                    } else {
                        maxValue = max(maxValue, dimensions.width)
                    }
                    
                    nextTop = top
                    top -= dimensions.height + verticalSpacing
                    return leading
                    
                case .vertical:
                    if (abs(leading - dimensions.width) > size.width) {
                        top -= (leading == 0 ? dimensions.height : maxValue) + verticalSpacing
                        leading = 0
                        maxValue = dimensions.height
                    } else {
                        maxValue = max(maxValue, dimensions.height)
                    }
                    
                    let nextLeading = leading
                    nextTop = top
                    leading -= dimensions.width + horizontalSpacing
                    return nextLeading
                }
            }
            .alignmentGuide(.top) { _ in nextTop }
        
        Color.clear
            .frame(width: 0, height: 0)
            .alignmentGuide(.leading) { _ in
                leading = 0
                top = 0
                nextTop = 0
                maxValue = 0
                return 0
            }
            .hidden()
    }
}
