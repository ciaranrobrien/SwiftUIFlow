/**
*  SwiftUIFlow
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public struct HFlow<Content>: View
where Content : View
{
    public var body: some View {
        Flow(axis: .horizontal,
             content: content,
             horizontalSpacing: horizontalSpacing,
             verticalSpacing: verticalSpacing)
    }
    
    private var content: () -> Content
    private var horizontalSpacing: CGFloat?
    private var verticalSpacing: CGFloat?
}


public extension HFlow {
    /// A view that arranges its children in a horizontal flow.
    ///
    /// - Parameters:
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the flow to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.init(horizontalSpacing: spacing,
                  verticalSpacing: spacing,
                  content: content)
    }
    
    /// A view that arranges its children in a horizontal flow.
    ///
    /// - Parameters:
    ///   - horizontalSpacing: The distance between adjacent columns of
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of columns.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content
    }
}
