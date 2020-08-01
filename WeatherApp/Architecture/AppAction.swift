import Foundation
import SwiftUI

enum AppAction: Equatable {
  case searchTermChanged(String)
  case currentConditionResponse(Result<CurrentConditionResponse, APIFailure>)
  case forecastResponse(Result<ForecastResponse, APIFailure>)
  case conditionImageChanged(Result<Image, APIFailure>)
  case alertDismissed
}
