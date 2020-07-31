import Foundation
import SwiftUI

enum AppAction: Equatable {
  case searchTermChanged(String)
  case currentConditionResponse(Result<CurrentConditionResponse, WeatherClientFailure>)
  case conditionImageChanged(Result<Image, ImageFailure>)
}
