/**
*  SwiftUIFlow
*  Copyright (c) Ciaran O'Brien 2022
*  MIT license, see LICENSE file for details
*/

import SwiftUI

public struct VFlow<Content>: View
where Content : View
{
    public var body: Flow<Content>
}


public extension VFlow {
    /// A view that arranges its children in a vertical flow.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this flow. This
    ///     guide has the same horizontal screen coordinate for every child view.
    ///   - spacing: The distance between adjacent subviews, or `nil` if you
    ///     want the flow to choose a default distance for each pair of
    ///     subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(alignment: HorizontalAlignment = .center,
         spacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.body = Flow(.vertical,
                         alignment: Alignment(horizontal: alignment, vertical: .top),
                         spacing: spacing,
                         content: content)
    }
    
    /// A view that arranges its children in a vertical flow.
    ///
    /// This view returns a flexible preferred width to its parent layout.
    ///
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this flow. This
    ///     guide has the same horizontal screen coordinate for every child view.
    ///   - horizontalSpacing: The distance between horizontally adjacent
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of subviews.
    ///   - verticalSpacing: The distance between vertically adjacent
    ///     subviews, or `nil` if you want the flow to choose a default distance
    ///     for each pair of subviews.
    ///   - content: A view builder that creates the content of this flow.
    init(alignment: HorizontalAlignment = .center,
         horizontalSpacing: CGFloat? = nil,
         verticalSpacing: CGFloat? = nil,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.body = Flow(.vertical,
                         alignment: Alignment(horizontal: alignment, vertical: .top),
                         horizontalSpacing: horizontalSpacing,
                         verticalSpacing: verticalSpacing,
                         content: content)
    }
}
