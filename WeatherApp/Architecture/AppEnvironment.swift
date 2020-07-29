import Foundation
import ComposableArchitecture

struct AppEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var weatherResponse: (String) -> Effect<String, ApiError>
}
