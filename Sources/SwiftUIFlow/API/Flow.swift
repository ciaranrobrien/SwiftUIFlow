/**
*  SwiftUIFlow
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public struct Flow<Content>: View
where Content : View
{
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: alignment) {
                Color.clear
                    .hidden()
                
                FlowLayout(alignment: alignment,
                           axis: axis,
                           content: content,
                           horizontalSpacing: horizontalSpacing ?? 8,
                           size: geometry.size,
                           verticalSpacing: verticalSpacing ?? 8)
                .transaction {
                    let newValue = $0
                    DispatchQueue.main.async {
                        transaction = newValue
                    }
                }
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear { contentSize = geometry.size }
                            .onChange(of: geometry.size) { newValue in
                                DispatchQueue.main.async {
                                    withTransaction(transaction) {
                                        contentSize = newValue
                                    }
                                }
                            }
                    }
                    .hidden()
                )
            }
        }
        .frame(width: axis == .horizontal ? contentSize.width : nil,
               height: axis == .vertical ? contentSize.height : nil)
    }
    
    @State private var contentSize = CGSize.zero
    @State private var transaction = Transaction()
    
    private var alignment: Alignment
    private var axis: Axis
    private var content: () -> Content
    private var horizontalSpacing: CGFloat?
    private var verticalSpacing: CGFloat?
}


public extension Flow {
    /// A view that arranges its children in a flow.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this flow.
    ///   - alignment: The guide for aligning the subviews in this flow on both
    ///     the x- and y-axes.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the flow to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(_ axis: Axis,
         alignment: Alignment = .center,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.alignment = alignment
        self.axis = axis
        self.content = content
        self.horizontalSpacing = spacing
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a flow.
    ///
    /// This view returns a flexible preferred size, orthogonal to the layout axis, to its parent layout.
    ///
    /// - Parameters:
    ///   - axis: The layout axis of this flow.
    ///   - alignment: The guide for aligning the subviews in this flow on both
    ///     the x- and y-axes.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(_ axis: Axis,
         alignment: Alignment = .center,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.alignment = alignment
        self.axis = axis
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }
}
