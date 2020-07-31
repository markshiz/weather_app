import Foundation
import SwiftUI
import ComposableArchitecture

enum APIFailure: Error, Equatable {
    case weatherClientFailure
    case imageFailure
}

protocol WeatherClientProtocol {
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, APIFailure>
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, APIFailure>
    
    func conditionImageFromString(string: String) -> Effect<Image, APIFailure>
}

class WeatherClient: WeatherClientProtocol {
    // MARK: Endpoints
    
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, APIFailure> {
        guard let components = URLComponentsFactory().create(query: query, endpoint: .weather) else { return Effect(error: .weatherClientFailure) }
        return performRequest(components: components)
    }
    
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, APIFailure> {
        guard let components = URLComponentsFactory().create(query: query, endpoint: .forecast) else { return Effect(error: .weatherClientFailure) }
        return performRequest(components: components)
    }
    
    // MARK: Image
    
    func conditionImageFromString(string: String) -> Effect<Image, APIFailure> {
        guard let components = URLComponents(string: "https://openweathermap.org/img/wn/\(string)@2x.png") else { return Effect(error: .imageFailure)}
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { data, _ in Image(uiImage: UIImage(data: data)!) }
            .mapError { _ in .imageFailure }
            .eraseToEffect()
    }
    
    // MARK: Helpers
    
    private func performRequest<T: Decodable>(components: URLComponents) -> Effect<T, APIFailure> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
          .map { data, _ in data }
          .decode(type: T.self, decoder: DefaultJSONDecoder())
          .mapError { error in
            print("API Error: \(error)")
            return .weatherClientFailure
          }.eraseToEffect()
    }
}
