import Foundation
import ComposableArchitecture

struct WeatherClientFailure: Error, Equatable {}

protocol WeatherClientProtocol {
    func searchByCity(city: String) -> Effect<CurrentConditionResponse, WeatherClientFailure>
    func searchByZipcode(zipcode: String) -> Effect<CurrentConditionResponse, WeatherClientFailure>
    func searchByCoordinates(lat: Double, lon: Double) -> Effect<CurrentConditionResponse, WeatherClientFailure>
}

class WeatherClient: WeatherClientProtocol {
    func searchByCity(city: String) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        let queryParameters = [URLQueryItem(name: "q", value: city),
                               URLQueryItem(name: "appid", value: Constants.API_KEY)]
        return performRequest(queryParameters: queryParameters)
    }
    
    func searchByZipcode(zipcode: String) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        let queryParameters = [URLQueryItem(name: "zip", value: "\(zipcode),us"),
                               URLQueryItem(name: "appid", value: Constants.API_KEY)]
        return performRequest(queryParameters: queryParameters)
    }
    
    func searchByCoordinates(lat: Double, lon: Double) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        let queryParameters = [URLQueryItem(name: "lat", value: String(lat)),
                               URLQueryItem(name: "lon", value: String(lon)),
                               URLQueryItem(name: "appid", value: Constants.API_KEY)]
        return performRequest(queryParameters: queryParameters)
    }
    
    private func performRequest(queryParameters: [URLQueryItem]) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        guard var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") else { return Effect(error: WeatherClientFailure())  }
        components.queryItems = queryParameters
        return URLSession.shared.dataTaskPublisher(for: components.url!)
          .map { data, _ in data }
          .decode(type: CurrentConditionResponse.self, decoder: DefaultJSONDecoder())
          .mapError { _ in WeatherClientFailure() }
          .eraseToEffect()
    }
}
