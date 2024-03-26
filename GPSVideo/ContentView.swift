import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location = locationManager.currentLocation {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            } else {
                Text("Location data is not available.")
            }
            
            if locationManager.isTracking {
                Text("Time since last update: \(locationManager.timeDifferenceInSeconds, specifier: "%.2f") seconds")
            }
            
            Button(action: {
                if locationManager.isTracking {
                    locationManager.stopTracking()
                } else {
                    locationManager.startTracking()
                }
            }) {
                Text(locationManager.isTracking ? "Stop Tracking" : "Start Tracking")
                    .foregroundColor(.white)
                    .padding()
                    .background(locationManager.isTracking ? Color.red : Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
