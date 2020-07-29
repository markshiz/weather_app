import SwiftUI
import MapKit

struct ContentView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        VStack {
            MapView(coordinate: coordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 150)
            CircleImage(image: DEFAULT_WEATHER_IMAGE)
                .frame(width: 100, height: 100)
                .offset(y: -50)
                .padding(.bottom, -50)
            VStack(alignment: .leading) {
                Text("Partly Sunny")
                    .font(.title)
                HStack(alignment: .top) {
                    Text("Emerson Electric")
                        .font(.subheadline)
                    Spacer()
                    Text("72°F")
                        .font(.headline)
                }
            }
            .padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinate: START_LOCATION)
    }
}
