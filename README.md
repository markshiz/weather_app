# WeatherApp

A simple app that checks the weather and current conditions using [Swift Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture).

<p float="left">
<img width="150" alt="Light Mode" src="https://storage.googleapis.com/mobconverge-blog/github/light_mode.PNG">
<img width="150" alt="Dark Mode" src="https://storage.googleapis.com/mobconverge-blog/github/dark_mode.PNG">
</p>

## Why Swift Composable Architecture?

The library takes ideas from Facebook's Redux and Elm, using unidirectional flow --and particularly a reducer object-- to process all state changes.  These state changes then get emitted/propogated back to the view via an observation regime.  This library makes presentation layer state changes (which are all contained inside an `Equatable` struct) and associated side-effects very testable and declarative.  SCA also works very well with SwiftUI and Combine, the foundations of new UI for iOS 13.

## Xcode Version

Built with Xcode 11.6

## Minimum iOS Version 

iOS 13, due to the use of SwiftUI.

## API 

The app uses the free API from [openweathermap.org](https://openweathermap.org/api) to pull weather details.  A sample API key is committed.  Under normal circumstances this key would likely be hosted by a private API server.

## UI

Views are built using Swift UI.  As a consequence we are sort of forced into using Swift Combine here and there.  I've minimized usage of its more complex operators to keep things easy to understand and easy to extend.
