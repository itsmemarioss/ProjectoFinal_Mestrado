

import Foundation

//1º Passo importar a biblioteca
import CoreLocation

class LocationViewModel : NSObject, ObservableObject{
    
    @Published var locations: [CLLocationCoordinate2D] = []
    
    var manager : CLLocationManager?
    var lastLocation : CLLocation?
    var stats: StatsViewModel
       
    init(stats: StatsViewModel) {
        self.stats = stats
        super.init()
        //2ºPasso instaciar o location manager
        manager = CLLocationManager()
        manager!.delegate = self
    }
    
    //3ºPedir permissão para usar gps
    func askPermission(){
        guard let m = manager else {return}
        m.requestWhenInUseAuthorization()
    }
    
    //4º Pedir a localização
    func getLocation(){
        guard let m = manager else {return}
        if(m.authorizationStatus == .authorizedWhenInUse){
            
            m.startUpdatingLocation()
            
        }
    }
    func stopLocation(){
        guard let m = manager else {return}
        m.stopUpdatingLocation()
        
    }
    func clearLocations(){
        self.locations = []
    }
}

extension LocationViewModel : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let p = locations.last else {return}
        
        self.locations.append(CLLocationCoordinate2D(latitude: p.coordinate.latitude, longitude: p.coordinate.longitude))
        self.lastLocation = locations.last
        stats.updatePosition(lastLocation!)
    }
}
