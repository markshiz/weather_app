import Foundation
import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
  case .searchTermChanged(let term):
    let result = QueryParser().parse(term: term)
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
