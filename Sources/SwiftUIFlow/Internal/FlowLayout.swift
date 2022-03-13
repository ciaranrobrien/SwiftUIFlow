/**
*  SwiftUIFlow
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct FlowLayout<Content>: View
where Content : View
{
    var alignment: Alignment
    var axis: Axis
    var content: () -> Content
    var horizontalSpacing: CGFloat
    var size: CGSize
    var verticalSpacing: CGFloat
    
    var body: some View {
        var alignments: [CGSize] = []
        
        var currentIndex = 0
        var lineFirstIndex = 0
        var isLastLineAdjusted = false
        var leading: CGFloat = 0
        var top: CGFloat = 0
        var maxValue: CGFloat = 0
        var maxLineValue: CGFloat = 0
        var maxIndex: Int? = nil
        
        ZStack(alignment: .topLeading) {
            content()
                .fixedSize()
                .alignmentGuide(.leading) { dimensions in
                    if let maxIndex = maxIndex, currentIndex > maxIndex {
                        currentIndex %= maxIndex
                    }
                    
                    if alignments.indices.contains(currentIndex) {
                        return alignments[currentIndex].width
                    }
                    
                    switch axis {
                    case .horizontal:
                        if (abs(top - dimensions.height) > size.height) {
                            //Adjust previous lines
                            if -top > maxLineValue {
                                let adjustment = (maxLineValue + top)
                                * (dimensions[alignment.vertical] / dimensions[.bottom])
                                
                                for index in 0..<lineFirstIndex {
                                    alignments[index].height += adjustment
                                }
                            }
                            
                            maxLineValue = max(maxLineValue, -top)
                            
                            let adjustment = (maxLineValue + top)
                            * (dimensions[alignment.vertical] / dimensions[.bottom])
                            
                            //Adjust current line
                            for index in lineFirstIndex..<currentIndex {
                                alignments[index].height -= adjustment
                            }
                            
                            leading -= (top == 0 ? dimensions.width : maxValue) + horizontalSpacing
                            top = 0
                            lineFirstIndex = currentIndex
                            maxValue = dimensions.width
                        } else {
                            maxValue = max(maxValue, dimensions.width)
                        }
                        
                        alignments.append(CGSize(width: leading, height: top))
                        top -= dimensions.height + verticalSpacing
                        return alignments[currentIndex].width
                        
                    case .vertical:
                        if (abs(leading - dimensions.width) > size.width) {
                            //Adjust previous lines
                            if -leading > maxLineValue {
                                let adjustment = (maxLineValue + leading)
                                * (dimensions[alignment.horizontal] / dimensions[.trailing])
                                
                                for index in 0..<lineFirstIndex {
                                    alignments[index].width += adjustment
                                }
                            }
                            
                            maxLineValue = max(maxLineValue, -leading)
                            
                            let adjustment = (maxLineValue + leading)
                            * (dimensions[alignment.horizontal] / dimensions[.trailing])
                            
                            //Adjust current line
                            for index in lineFirstIndex..<currentIndex {
                                alignments[index].width -= adjustment
                            }
                            
                            top -= (leading == 0 ? dimensions.height : maxValue) + verticalSpacing
                            leading = 0
                            lineFirstIndex = currentIndex
                            maxValue = dimensions.height
                        } else {
                            maxValue = max(maxValue, dimensions.height)
                        }
                        
                        alignments.append(CGSize(width: leading, height: top))
                        leading -= dimensions.width + horizontalSpacing
                        return alignments[currentIndex].width
                    }
                }
                .alignmentGuide(.top) { _ in
                    if let maxIndex = maxIndex, currentIndex > maxIndex {
                        currentIndex %= maxIndex
                    }
                    
                    let top: CGFloat
                    if alignments.indices.contains(currentIndex) {
                        top = alignments[currentIndex].height
                    } else {
                        top = 0
                    }
                    
                    currentIndex += 1
                    return top
                }
            
            Color.clear
                .frame(width: 1, height: 1)
                .alignmentGuide(.leading) { dimensions in
                    if maxIndex == nil {
                        maxIndex = currentIndex
                    }
                    
                    if !isLastLineAdjusted, let lastIndex = alignments.indices.last {
                        switch axis {
                        case .horizontal:
                            let adjustment = (maxLineValue + top)
                            * (dimensions[alignment.vertical] / dimensions[.bottom])
                            
                            for index in lineFirstIndex...lastIndex {
                                alignments[index].height -= adjustment
                            }
                            
                        case .vertical:
                            let adjustment = (maxLineValue + leading)
                            * (dimensions[alignment.horizontal] / dimensions[.trailing])
                            
                            for index in lineFirstIndex...lastIndex {
                                alignments[index].width -= adjustment
                            }
                        }
                        
                        isLastLineAdjusted = true
                    }
                    
                    currentIndex = 0
                    lineFirstIndex = 0
                    leading = 0
                    top = 0
                    maxValue = 0
                    maxLineValue = 0
                    return 0
                }
                .hidden()
        }
        .frame(width: axis == .vertical ? 0 : nil,
               height: axis == .horizontal ? 0 : nil,
               alignment: alignment)
    }
}
