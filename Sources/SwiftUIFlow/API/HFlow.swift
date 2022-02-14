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
        Flow(.horizontal,
             alignment: Alignment(horizontal: .leading, vertical: verticalAlignment),
             horizontalSpacing: horizontalSpacing,
             verticalSpacing: verticalSpacing,
             content: content)
    }
    
    private var content: () -> Content
    private var horizontalSpacing: CGFloat?
    private var verticalAlignment: VerticalAlignment
    private var verticalSpacing: CGFloat?
}


public extension HFlow {
    /// A view that arranges its children in a horizontal flow.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this flow. This
    ///     guide has the same vertical screen coordinate for every child view.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the flow to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(alignment: VerticalAlignment = .center,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = spacing
        self.verticalAlignment = alignment
        self.verticalSpacing = spacing
    }
    
    /// A view that arranges its children in a horizontal flow.
    ///
    /// This view returns a flexible preferred height to its parent layout.
    ///
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this flow. This
    ///     guide has the same vertical screen coordinate for every child view.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(alignment: VerticalAlignment = .center,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.content = content
        self.horizontalSpacing = horizontalSpacing
        self.verticalAlignment = alignment
        self.verticalSpacing = verticalSpacing
    }
}
