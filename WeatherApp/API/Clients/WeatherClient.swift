import Foundation
import SwiftUI
import ComposableArchitecture

enum APIFailure: Error, Equatable {
    case weatherClientBadStatus(code: Int)
    case weatherClientBadResponse
    case weatherClientNotFound
    case weatherClientDecoding
    case weatherClientBadURL
    case imageFailure
}

protocol WeatherClientProtocol {
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, APIFailure>
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, APIFailure>
    
    func conditionImageFromTag(tag: String) -> Effect<Image, APIFailure>
}

class WeatherClient: WeatherClientProtocol {
    // MARK: Endpoints
    
    func weather(query: QueryParser.ResultType) -> Effect<CurrentConditionResponse, APIFailure> {
        guard let components = URLComponentsFactory().create(query: query, endpoint: .weather) else { return Effect(error: .weatherClientBadURL) }
        return performRequest(components: components)
    }
    
    func forecast(query: QueryParser.ResultType) -> Effect<ForecastResponse, APIFailure> {
        guard let components = URLComponentsFactory().create(query: query, endpoint: .forecast) else { return Effect(error: .weatherClientBadURL) }
        return performRequest(components: components)
    }
    
    // MARK: Image
    
    func conditionImageFromTag(tag: String) -> Effect<Image, APIFailure> {
        guard let components = URLComponents(string: "https://openweathermap.org/img/wn/\(tag)@2x.png") else { return Effect(error: .imageFailure)}
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { data, _ in Image(uiImage: UIImage(data: data)!) }
            .mapError { _ in .imageFailure }
            .eraseToEffect()
    }
    
    // MARK: Helpers
    
    private func performRequest<T: Decodable>(components: URLComponents) -> Effect<T, APIFailure> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
          .tryMap() { (data, response) -> Data in
            guard let http = response as? HTTPURLResponse else {
                throw APIFailure.weatherClientBadResponse
            }
            if http.statusCode == 404 {
                throw APIFailure.weatherClientNotFound
            } else if http.statusCode != 200 {
                throw APIFailure.weatherClientBadStatus(code: http.statusCode)
            }
            return data
          }
          .decode(type: T.self, decoder: DefaultJSONDecoder())
          .mapError { error in
            guard let error = error as? APIFailure else {
                return .weatherClientDecoding
            }
            return error
          }
          .eraseToEffect()
    }
}
