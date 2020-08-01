# WeatherApp

A simple app that checks the weather and current conditions using [Swift Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture).

## Why Swift Composable Architecture?

The library takes ideas from Facebook's Redux and ReSwift, using unidirectional flow, and a reducer to process all state changes, which then get emitted/propogated back to the view.  This library makes presentation layer state changes very testable and declarative.  SCA also works very well with SwiftUI and Combine.

## Xcode Version

Built with Xcode 11.6

## Minimum iOS Version 

iOS 13

## API 

The app uses the free API from [openweathermap.org](https://openweathermap.org/api) to pull weather details.  A sample API key is committed.

## UI

Views are built using Swift UI.  As a consequence we are sort of forced into using Swift Combine here and there.  I've minimized usage of its more complex operators to keep things easy to understand and easy to extend.

