import Foundation
import ComposableArchitecture

struct AppEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var currentConditionResponse: (String) -> Effect<CurrentConditionResponse, ApiError>
}
