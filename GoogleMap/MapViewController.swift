//
//  MapViewController.swift
//  GoogleMap
//
//  Created by tomoki hoshikawa on 2021/09/25.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    var locationManager: CLLocationManager!
      var currentLocation: CLLocation?
      var mapView: GMSMapView!
      var placesClient: GMSPlacesClient!
      var preciseLocationZoomLevel: Float = 15.0
      var approximateLocationZoomLevel: Float = 10.0

      // An array to hold the list of likely places.
      var likelyPlaces: [GMSPlace] = []

      // The currently selected place.
      var selectedPlace: GMSPlace?

      // Update the map once the user has made their selection.
      @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        // Clear the map.
        mapView.clear()

        // Add a marker to the map.
        if let place = selectedPlace {
          let marker = GMSMarker(position: place.coordinate)
          marker.title = selectedPlace?.name
          marker.snippet = selectedPlace?.formattedAddress
          marker.map = mapView
        }

        listLikelyPlaces()
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
            locationManager.delegate = self

            placesClient = GMSPlacesClient.shared()

            // A default location to use when location permission is not granted.
            let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
            
            // Create a map.
            let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
            let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                                  longitude: defaultLocation.coordinate.longitude,
                                                  zoom: zoomLevel)
            mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
            mapView.settings.myLocationButton = true
            mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mapView.isMyLocationEnabled = true

            // Add the map to the view, hide it until we've got a location update.
            view.addSubview(mapView)
            mapView.isHidden = true

            listLikelyPlaces()
    }
    
    // Populate the array with the list of likely places.
     func listLikelyPlaces() {
       // Clean up from previous sessions.
       likelyPlaces.removeAll()

       let placeFields: GMSPlaceField = [.name, .coordinate]
       placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { (placeLikelihoods, error) in
         guard error == nil else {
           // TODO: Handle the error.
           print("Current Place error: \(error!.localizedDescription)")
           return
         }

         guard let placeLikelihoods = placeLikelihoods else {
           print("No places found.")
           return
         }
         
         // Get likely places and add to the list.
         for likelihood in placeLikelihoods {
           let place = likelihood.place
           self.likelyPlaces.append(place)
         }
       }
     }
}

//     // Prepare the segue.
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       if segue.identifier == "segueToSelect" {
//         if let nextViewController = segue.destination as? PlacesViewController {
//           nextViewController.likelyPlaces = likelyPlaces
//         }
//       }
//     }
//   }

   // Delegates to handle events for the location manager.
   extension MapViewController: CLLocationManagerDelegate {

     // Handle incoming location events.
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location: CLLocation = locations.last!
       print("Location: \(location)")

       let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
       let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                             longitude: location.coordinate.longitude,
                                             zoom: zoomLevel)

       if mapView.isHidden {
         mapView.isHidden = false
         mapView.camera = camera
       } else {
         mapView.animate(to: camera)
       }

       listLikelyPlaces()
     }

     // Handle authorization for the location manager.
     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       // Check accuracy authorization
       let accuracy = manager.accuracyAuthorization
       switch accuracy {
       case .fullAccuracy:
           print("Location accuracy is precise.")
       case .reducedAccuracy:
           print("Location accuracy is not precise.")
       @unknown default:
         fatalError()
       }
       
       // Handle authorization status
       switch status {
       case .restricted:
         print("Location access was restricted.")
       case .denied:
         print("User denied access to location.")
         // Display the map using the default location.
         mapView.isHidden = false
       case .notDetermined:
         print("Location status not determined.")
       case .authorizedAlways: fallthrough
       case .authorizedWhenInUse:
         print("Location status is OK.")
       @unknown default:
         fatalError()
       }
     }

     // Handle location manager errors.
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       locationManager.stopUpdatingLocation()
       print("Error: \(error)")
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   }
