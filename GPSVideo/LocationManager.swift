//
//  File.swift
//  GPSVideo
//
//  Created by Griffin Baker on 3/26/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var lastUpdateTime: Date?
    @Published var timeDifferenceInSeconds: TimeInterval = 0
    @Published var isTracking: Bool = false

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startTracking() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        isTracking = true
    }
    
    func stopTracking() {
        self.locationManager.stopUpdatingLocation()
        isTracking = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        
        let now = Date()
        if let lastUpdate = lastUpdateTime {
            timeDifferenceInSeconds = now.timeIntervalSince(lastUpdate)
        }
        lastUpdateTime = now
    }
}
