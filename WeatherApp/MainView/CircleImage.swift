import SwiftUI

struct CircleImage: View {
    @Environment(\.colorScheme) var colorScheme
    
    var image: Image

    var body: some View {
        image
            .resizable()
            .background(Color(UIColor.systemBackground))
            .clipShape(Circle())
            .scaledToFit()
            .overlay(Circle().stroke(colorScheme == .dark ? Color.gray : .white, lineWidth: 1))
            .shadow(color: .gray, radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Constants.DEFAULT_WEATHER_IMAGE)
    }
}
