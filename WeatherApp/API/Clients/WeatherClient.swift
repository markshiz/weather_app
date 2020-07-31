import Foundation
import SwiftUI
import ComposableArchitecture

struct WeatherClientFailure: Error, Equatable {}
struct ImageFailure: Error, Equatable {}

protocol WeatherClientProtocol {
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, WeatherClientFailure>
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, WeatherClientFailure>
    
    func conditionImageFromString(string: String) -> Effect<Image, ImageFailure>
}

class WeatherClient: WeatherClientProtocol {
    // MARK: Endpoints
    
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, WeatherClientFailure> {
        guard let components = URLComponentsFactory().create(query: query, endpoint: .weather) else { return Effect(error: WeatherClientFailure()) }
        return performRequest(components: components)
    }
    
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, WeatherClientFailure> {
        guard let components = URLComponentsFactory().create(query: query, endpoint: .forecast) else { return Effect(error: WeatherClientFailure()) }
        return performRequest(components: components)
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
    
    private func performRequest<T: Decodable>(components: URLComponents) -> Effect<T, WeatherClientFailure> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
          .map { data, _ in data }
          .decode(type: T.self, decoder: DefaultJSONDecoder())
          .mapError { error in
            print("API Error: \(error)")
            return WeatherClientFailure()
          }.eraseToEffect()
    }
}
