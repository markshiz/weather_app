import SwiftUI
import MapKit

struct ContentView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        VStack {
            MapView(coordinate: coordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 200)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinate: START_LOCATION)
    }
}
