import SwiftUI
import Combine

class ImageFetcher: ObservableObject {
    @Published var image: Image?
    private var cancellable: AnyCancellable?
    private let tag: String
    private let weatherClient: WeatherClient

    init(tag: String, weatherClient: WeatherClient = WeatherClient()) {
        self.tag = tag
        self.weatherClient = weatherClient
    }
    
    func load() {
        self.cancellable = weatherClient.conditionImageFromTag(tag: tag)
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}
