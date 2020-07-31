import Foundation
import SwiftUI
import ComposableArchitecture

struct WeatherClientFailure: Error, Equatable {}
struct ImageFailure: Error, Equatable {}

protocol WeatherClientProtocol {
    func searchByCity(city: String) -> Effect<CurrentConditionResponse, WeatherClientFailure>
    func searchByZipcode(zipcode: String) -> Effect<CurrentConditionResponse, WeatherClientFailure>
    func searchByCoordinates(lat: Double, lon: Double) -> Effect<CurrentConditionResponse, WeatherClientFailure>
    
    func searchForecast(cityID: Int) -> Effect<ForecastResponse, WeatherClientFailure>
    
    func conditionImageFromString(string: String) -> Effect<Image, ImageFailure>
}

class WeatherClient: WeatherClientProtocol {
    // MARK: Current Conditions
    
    func searchByCity(city: String) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        let queryParameters = [URLQueryItem(name: "q", value: city),
                               URLQueryItem(name: "appid", value: Constants.API_KEY)]
        return performCurrentConditionRequest(queryParameters: queryParameters)
    }
    
    func searchByZipcode(zipcode: String) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        let queryParameters = [URLQueryItem(name: "zip", value: "\(zipcode),us"),
                               URLQueryItem(name: "appid", value: Constants.API_KEY)]
        return performCurrentConditionRequest(queryParameters: queryParameters)
    }
    
    func searchByCoordinates(lat: Double, lon: Double) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        let queryParameters = [URLQueryItem(name: "lat", value: String(lat)),
                               URLQueryItem(name: "lon", value: String(lon)),
                               URLQueryItem(name: "appid", value: Constants.API_KEY)]
        return performCurrentConditionRequest(queryParameters: queryParameters)
    }
    
    // MARK: Forecast
    
    func searchForecast(cityID: Int) -> Effect<ForecastResponse, WeatherClientFailure> {
        guard var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast/daily") else { return Effect(error: WeatherClientFailure())  }
        components.queryItems = [URLQueryItem(name: "id", value: String(cityID)),
                                 URLQueryItem(name: "appid", value: Constants.API_KEY)]
        return URLSession.shared.dataTaskPublisher(for: components.url!)
          .map { data, _ in data }
          .decode(type: ForecastResponse.self, decoder: DefaultJSONDecoder())
          .mapError { _ in WeatherClientFailure() }
          .eraseToEffect()
    }
    
    // MARK: Image
    
    func conditionImageFromString(string: String) -> Effect<Image, ImageFailure> {
        guard let components = URLComponents(string: "https://openweathermap.org/img/wn/\(string)@2x.png") else { return Effect(error: ImageFailure())}
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { data, _ in Image(uiImage: UIImage(data: data)!) }
            .mapError { _ in ImageFailure() }
            .eraseToEffect()
    }
    
    // MARK: Helpers
    
    private func performCurrentConditionRequest(queryParameters: [URLQueryItem]) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        guard var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") else { return Effect(error: WeatherClientFailure())  }
        components.queryItems = queryParameters
        return URLSession.shared.dataTaskPublisher(for: components.url!)
          .map { data, _ in data }
          .decode(type: CurrentConditionResponse.self, decoder: DefaultJSONDecoder())
          .mapError { _ in WeatherClientFailure() }
          .eraseToEffect()
    }
}
