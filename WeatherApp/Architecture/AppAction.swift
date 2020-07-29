import Foundation

enum AppAction: Equatable {
  case searchExecuted
  case currentConditionResponse(Result<CurrentConditionResponse, ApiError>)
}

struct ApiError: Error, Equatable {}
