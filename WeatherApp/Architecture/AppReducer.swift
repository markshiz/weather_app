import Foundation
import ComposableArchitecture
import CoreLocation
import SwiftUI

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, env in
  switch action {
  case .searchTermChanged(let term):
    state.searchQuery = term
    state.query = QueryParser().parse(term: term)
    return env.weatherClient.weather(query: state.query).scheduled(scheduler: env.mainQueue)
  case .currentConditionResponse(.success(let response)):
    state.locationName = response.name
    state.condition = response.weather[0].main
    state.locationCoordinate = CLLocationCoordinate2D(latitude: response.coord.lat, longitude: response.coord.lon)
    state.temperatureDegrees = KelvinToFarenheight(value: response.main.temp)
    return .merge(
        env.weatherClient.conditionImageFromTag(tag: response.weather[0].icon).scheduled(scheduler: env.mainQueue),
        env.weatherClient.forecast(query: state.query).scheduled(scheduler: env.mainQueue)
    )
  case .conditionImageChanged(.success(let image)):
    state.conditionImage = image
    return .none
  case .forecastResponse(.success(let response)):
    state.dailyWeather = response.list.map { item -> DailyWeather in
        return DailyWeather(forecast: item)
    }
    return .none
  case .alertDismissed:
    state.showAlert = false
    return .none
  default:
    state.showAlert = true
    return .none
  }
}

struct ImageRequest: Hashable {}
extension Effect where Output == Image, Failure == APIFailure {
    func scheduled(scheduler: AnySchedulerOf<DispatchQueue>) -> Effect<AppAction, Never> {
        return self
            .receive(on: scheduler)
            .catchToEffect()
            .map(AppAction.conditionImageChanged)
            .cancellable(id: ImageRequest(), cancelInFlight: true)
    }
}

extension Effect where Output == ForecastResponse, Failure == APIFailure {
    func scheduled(scheduler: AnySchedulerOf<DispatchQueue>) -> Effect<AppAction, Never> {
        return self
            .receive(on: scheduler)
            .catchToEffect()
            .map(AppAction.forecastResponse)
            .cancellable(id: Endpoint.forecast, cancelInFlight: true)
    }
}

extension Effect where Output == CurrentConditionResponse, Failure == APIFailure {
    func scheduled(scheduler: AnySchedulerOf<DispatchQueue>) -> Effect<AppAction, Never> {
        return self
            .receive(on: scheduler)
            .catchToEffect()
            .map(AppAction.currentConditionResponse)
            .debounce(id: Endpoint.weather, for: 0.3, scheduler: scheduler)
            .cancellable(id: Endpoint.weather, cancelInFlight: true)
    }
}

