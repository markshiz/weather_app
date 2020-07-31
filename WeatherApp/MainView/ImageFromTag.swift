import SwiftUI

struct ImageFromTag<Placeholder: View>: View {
    @ObservedObject private var fetcher: ImageFetcher
    private let placeholder: Placeholder?
    
    init(tag: String, placeholder: Placeholder? = nil) {
        self.fetcher = ImageFetcher(tag: tag)
        self.placeholder = placeholder
    }

    var body: some View {
        image
            .onAppear(perform: fetcher.load)
            .onDisappear(perform: fetcher.cancel)
    }
    
    private var image: some View {
        Group {
            if fetcher.image == nil {
                placeholder
            } else {
                fetcher.image?.resizable()
            }
        }
    }
}
