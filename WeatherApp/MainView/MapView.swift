import SwiftUI
import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    let renderer: MKTileOverlayRenderer
    
    init(renderer: MKTileOverlayRenderer) {
        self.renderer = renderer
    }
    
    func mapView(
      _ mapView: MKMapView,
      rendererFor overlay: MKOverlay
    ) -> MKOverlayRenderer {
      return renderer
    }
}

var tileOverlay: MKTileOverlay = {
    let tileOverlay = MKTileOverlay(urlTemplate: "https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=\(Constants.API_KEY)")
    tileOverlay.minimumZ = 2
    tileOverlay.maximumZ = 16
    tileOverlay.canReplaceMapContent = false
    return tileOverlay
}()

var delegate: MapViewDelegate = {
    let tileRenderer = MKTileOverlayRenderer(tileOverlay: tileOverlay)
    tileRenderer.alpha = 0.8
    return MapViewDelegate(renderer: tileRenderer)
}()


struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.mapType = MKMapType.mutedStandard
        mapView.addOverlay(tileOverlay, level: .aboveLabels)
        mapView.delegate = delegate
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: Constants.START_LOCATION)
    }
}
