

import SwiftUI
import MapKit

struct CustomMapView: UIViewRepresentable {
    
    @ObservedObject var l : LocationViewModel

    func makeCoordinator() -> CustomMapViewCoordinator {
        CustomMapViewCoordinator(self)
    }
    
    /**
     - Description - Replace the body with a make UIView(context:) method that creates and return an empty MKMapView
     */
    func makeUIView(context: Context) -> MKMapView{
        MKMapView(frame: .zero)
        
    }
   
    func updateUIView(_ view: MKMapView, context: Context){
        //If you changing the Map Annotation then you have to remove old Annotations
        view.removeOverlays(view.overlays)
        view.removeAnnotations(view.annotations)
        view.delegate = context.coordinator
        view.userTrackingMode = .follow
        view.showsUserLocation = true
       
        
        if l.locations.count > 0 {
            view.removeOverlays(view.overlays)
            let polyline = MKPolyline(coordinates: l.locations, count: l.locations.count)
            view.addOverlay(polyline)
        }
    }
}


/*
 Coordinator for using UIKit inside SwiftUI.
 */
class CustomMapViewCoordinator: NSObject, MKMapViewDelegate {
    
    var mapViewController: CustomMapView
    
    init(_ control: CustomMapView) {
        self.mapViewController = control
    }
    
   
    
    /**
     - Description - Changes the polyline aspect like color and line width
    */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .blue
      renderer.lineWidth = 3.0
      return renderer
    }
}
