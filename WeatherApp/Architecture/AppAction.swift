import Foundation

enum AppAction: Equatable {
  case searchExecuted
  case weatherResponse(Result<String, ApiError>)
}

struct ApiError: Error, Equatable {}
