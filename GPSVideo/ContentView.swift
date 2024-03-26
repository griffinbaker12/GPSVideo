import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location  = locationManager.currentLocation {
                if locationManager.isTracking {
                    Text("Latitude: \(location.latitude)")
                        .padding()
                    Text("Longitude: \(location.longitude)")
                        .padding()
                    if let mostRecentTime = locationManager.lastUpdateTime {
                        Text("Last Update Time: \(mostRecentTime)")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else {
                    Text("Press the 'Start Tracking' button to see your coordinates")
                        .multilineTextAlignment(.center)
                }
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
                    .animation(nil, value: locationManager.isTracking)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
