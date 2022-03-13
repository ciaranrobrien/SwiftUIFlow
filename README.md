# SwiftUI Flow

SwiftUI views that arrange their children in a flow layout.

![Demo](./Resources/Demo.gif "Demo")

## HFlow
A view that arranges its children in a horizontal flow.

### Usage
```swift
ScrollView(.horizontal) {
    HFlow(alignment: .top) {
        //Flow content
    }
}
```

### Parameters
* `alignment`: The guide for aligning the subviews in this flow. This guide has the same vertical screen coordinate for every child view.
* `spacing`: The distance between adjacent subviews, or `nil` if you want the flow to choose a default distance for each pair of subviews.
* `content`: A view builder that creates the content of this flow.

## VFlow
A view that arranges its children in a vertical flow.

### Usage
```swift
ScrollView(.vertical) {
    VFlow(alignment: .leading) {
        //Flow content
    }
}
```

### Parameters
* `alignment`: The guide for aligning the subviews in this flow. This guide has the same horizontal screen coordinate for every child view.
* `spacing`: The distance between adjacent subviews, or `nil` if you want the flow to choose a default distance for each pair of subviews.
* `content`: A view builder that creates the content of this flow.

## Flow
A view that arranges its children in a flow.

### Usage
```swift
ScrollView(.vertical) {
    Flow(.vertical, alignment: .topLeading) {
        //Flow content
    }
}
```

### Parameters
* `axis`: The layout axis of this flow.
* `alignment`: The guide for aligning the subviews in this flow on both the x- and y-axes.
* `spacing`: The distance between adjacent subviews, or `nil` if you want the flow to choose a default distance for each pair of subviews.
* `content`: A view builder that creates the content of this flow.

## Advanced Usage
The distance between adjacent subviews can be controlled in both axes, by using the `horizontalSpacing` and `verticalSpacing` parameters instead of the `spacing` parameter.

## Requirements

* iOS 14.0+, macOS 11.0+, tvOS 14.0+ or watchOS 7.0+
* Xcode 12.0+

## Installation

* Install with [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).
* Import `SwiftUIFlow` to start using.

## Contact

[@ciaranrobrien](https://twitter.com/ciaranrobrien) on Twitter.
