//
//  ViewController.swift
//  GoogleMap
//
//  Created by tomoki hoshikawa on 2021/07/05.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView = GMSMapView()
    
//    @IBOutlet weak var mapView: GMSMapView!
      private var locationManager: CLLocationManager!
      private var currentLocation: CLLocation?
      private var placesClient: GMSPlacesClient!
      private var zoomLevel: Float = 15.0
      /// 初期描画の判断に利用
      private var initView: Bool = false
    
    var locationManagers = CLLocationManager() // 追記

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMap()
        
        // GoogleMapの初期化
            self.mapView.isMyLocationEnabled = true
            self.mapView.mapType = GMSMapViewType.normal
            self.mapView.settings.compassButton = true
            self.mapView.settings.myLocationButton = true
            self.mapView.delegate = self

            // 位置情報関連の初期化
            self.locationManager = CLLocationManager()
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.requestAlwaysAuthorization()
            self.locationManager?.distanceFilter = 50
            self.locationManager?.startUpdatingLocation()
            self.locationManager?.delegate = self

            self.placesClient = GMSPlacesClient.shared()
        
        requestLoacion() // 追記
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    private func setupMap() {
            // GoogleMapの初期位置(仮で東京駅付近に設定)
            let camera = GMSCameraPosition.camera(withLatitude: 35.6812226, longitude: 139.7670594, zoom: 12.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
        }

        private func requestLoacion() {
            // ユーザにアプリ使用中のみ位置情報取得の許可を求めるダイアログを表示
            locationManagers.requestWhenInUseAuthorization()
            // 常に取得したい場合はこちら↓
            // locationManagers.requestAlwaysAuthorization()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.initView {
          // 初期描画時のマップ中心位置の移動
          let camera = GMSCameraPosition.camera(withTarget: (locations.last?.coordinate)!, zoom: self.zoomLevel)
          self.mapView.camera = camera
          self.locationManager?.stopUpdatingLocation()
          self.initView = true
        }
      }

}

