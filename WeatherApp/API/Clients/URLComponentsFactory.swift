import Foundation

enum Endpoint: String {
    case weather = "https://api.openweathermap.org/data/2.5/weather"
    case forecast = "https://api.openweathermap.org/data/2.5/forecast"
}

class URLComponentsFactory {
    
    func create(query: QueryParser.ResultType, endpoint: Endpoint) -> URLComponents? {
        guard var components = URLComponents(string: endpoint.rawValue) else { return nil }
        switch query {
        case .cityAndState(let city, let state):
            components.queryItems = [URLQueryItem(name: "q", value: "\(city), \(state)"),
                                     URLQueryItem(name: "appid", value: Constants.API_KEY)]
        case .cityName(let city):
            components.queryItems = [URLQueryItem(name: "q", value: city),
                                     URLQueryItem(name: "appid", value: Constants.API_KEY)]
        case .latitudeLongitude(let lat, let lon):
            components.queryItems = [URLQueryItem(name: "lat", value: String(lat)),
                                     URLQueryItem(name: "lon", value: String(lon)),
                                     URLQueryItem(name: "appid", value: Constants.API_KEY)]
        case .zipCode(let zip):
            components.queryItems = [URLQueryItem(name: "zip", value: "\(zip),us"),
                                     URLQueryItem(name: "appid", value: Constants.API_KEY)]
        case .unrecognized:
            return nil
        }
        return components
    }
}
