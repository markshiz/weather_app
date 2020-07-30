import Foundation

enum AppAction: Equatable {
  case searchTermChanged(String)
  case currentConditionResponse(Result<CurrentConditionResponse, ApiError>)
}

struct ApiError: Error, Equatable {}
