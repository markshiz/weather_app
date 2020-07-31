import Foundation
import ComposableArchitecture

struct AppEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var weatherClient: WeatherClientProtocol = WeatherClient()
}
