import CoreLocation
import CoreWLAN
import Foundation

class LocationActivator: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let client = CWWiFiClient.shared()
    
    func activate() {
        print("--- Iniciando Activador de WiFi ---")
        print("Si aparece un cuadro de diálogo, por favor haz clic en 'Permitir'.")
        
        locationManager.delegate = self
        // En macOS se usa simplemente requestAlwaysAuthorization o se comprueba el estado
        locationManager.requestAlwaysAuthorization()
        
        // Intentar leer el SSID inmediatamente
        if let interface = client.interface(), let ssid = interface.ssid() {
            print("SSID Detectado: \(ssid)")
            exit(0)
        } else {
            print("Esperando permisos...")
            // Mantener vivo el proceso 10 segundos para dar tiempo al usuario
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 10))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // En macOS modernos se usa .authorized
        if status == .authorizedAlways || status == .authorized {
            if let ssid = client.interface()?.ssid() {
                print("¡ÉXITO! SSID: \(ssid)")
                exit(0)
            }
        }
    }
}

let activator = LocationActivator()
activator.activate()
