import Foundation
import ComposableArchitecture
import CoreLocation
import SwiftUI

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, env in
  switch action {
  case .searchTermChanged(let term):
    state.searchQuery = term

    let result = QueryParser().parse(term: term)
    switch result {
    case .cityAndState(let city, let state):
        return env.weatherClient.searchByCity(city: city).scheduled(scheduler: env.mainQueue)
    case .cityName(let city):
        return env.weatherClient.searchByCity(city: city).scheduled(scheduler: env.mainQueue)
    case .latitudeLongitude(let lat, let lon):
        return env.weatherClient.searchByCoordinates(lat: lat, lon: lon).scheduled(scheduler: env.mainQueue)
    case .unrecognized:
        return .none
    case .zipCode(let zip):
        return env.weatherClient.searchByZipcode(zipcode: zip).scheduled(scheduler: env.mainQueue)
    }
    
  case .currentConditionResponse(.success(let response)):
    state.locationName = response.name
    state.condition = response.weather[0].main
    state.locationCoordinate = CLLocationCoordinate2D(latitude: response.coord.lat, longitude: response.coord.lon)
    state.temperatureDegrees = KelvinToFarenheight(value: response.main.temp)
    
    return .merge(
        env.weatherClient.conditionImageFromString(string: response.weather[0].icon).scheduled(scheduler: env.mainQueue),
        env.weatherClient.searchForecast(cityID: response.id).scheduled(scheduler: env.mainQueue)
    )
  case .currentConditionResponse(.failure(let error)):
    // TODO
    return .none
  case .conditionImageChanged(.success(let image)):
    state.conditionImage = image
    return .none
  case .conditionImageChanged(.failure(let error)):
    // TODO
    return .none
  case .forecastResponse(.success(let response)):
    return .none
  case .forecastResponse(.failure(let error)):
    return .none
  }
}

extension Effect where Output == Image, Failure == ImageFailure {
    func scheduled(scheduler: AnySchedulerOf<DispatchQueue>) -> Effect<AppAction, Never> {
        return self
            .receive(on: scheduler)
            .catchToEffect()
            .map(AppAction.conditionImageChanged)
            .cancellable(id: UUID(), cancelInFlight: true)
    }
}

extension Effect where Output == ForecastResponse, Failure == WeatherClientFailure {
    func scheduled(scheduler: AnySchedulerOf<DispatchQueue>) -> Effect<AppAction, Never> {
        return self
            .receive(on: scheduler)
            .catchToEffect()
            .map(AppAction.forecastResponse)
            .cancellable(id: UUID(), cancelInFlight: true)
    }
}

extension Effect where Output == CurrentConditionResponse, Failure == WeatherClientFailure {
    func scheduled(scheduler: AnySchedulerOf<DispatchQueue>) -> Effect<AppAction, Never> {
        return self
            .receive(on: scheduler)
            .catchToEffect()
            .map(AppAction.currentConditionResponse)
            .cancellable(id: UUID(), cancelInFlight: true)
    }
}

