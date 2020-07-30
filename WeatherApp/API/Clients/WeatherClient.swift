import Foundation
import ComposableArchitecture

protocol WeatherClientProtocol {
    func searchByCity(city: String) -> Effect<CurrentConditionResponse, ApiError>
}
