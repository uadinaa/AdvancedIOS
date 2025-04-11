import SwiftUI
import MapKit

struct WeatherRadarMapView: UIViewRepresentable {
    let apiKey: String
    let centerCoordinate: CLLocationCoordinate2D
    
    @State private var region: MKCoordinateRegion

    init(apiKey: String, centerCoordinate: CLLocationCoordinate2D) {
        self.apiKey = apiKey
        self.centerCoordinate = centerCoordinate
        _region = State(initialValue: MKCoordinateRegion(
            center: centerCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
        ))
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // Set initial region
        let center = CLLocationCoordinate2D(latitude: 43.24, longitude: 76.9)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0))
        mapView.setRegion(region, animated: false)

        // Add OpenWeather tile overlay
        let template = "https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=\(apiKey)"
        let overlay = MKTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = false // Show on top of Apple's map

        mapView.addOverlay(overlay, level: .aboveLabels)
        mapView.delegate = context.coordinator
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // No updates needed for now
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let tileOverlay = overlay as? MKTileOverlay {
                return MKTileOverlayRenderer(tileOverlay: tileOverlay)
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
