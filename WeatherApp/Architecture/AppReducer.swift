import Foundation
import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
  case .searchExecuted:
    // TODO
    return .none
  case .weatherResponse(.success(let response)):
    // TODO
    return .none
  case .weatherResponse(.failure(let error)):
    // TODO
    return .none
  }
}
