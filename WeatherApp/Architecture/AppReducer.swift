import Foundation
import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
  case .searchExecuted:
    // TODO
    return .none
  case .currentConditionResponse(.success(let response)):
    // TODO
    return .none
  case .currentConditionResponse(.failure(let error)):
    // TODO
    return .none
  }
}
