//
//  ViewController.swift
//  0728UIKitPractice
//
//  Created by 楊采庭 on 2017/7/28.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let segmentControl = UISegmentedControl(items: [ "Taipei 101", "2", "3", "4"])
    var mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        segmentControl.frame = CGRect(x: 50, y: 50, width: 300, height: 30)
        segmentControl.center.x = CGFloat(screenWidth/2)
        segmentControl.center.y = CGFloat(screenHeight/6)

        segmentControl.selectedSegmentIndex = 1

        //        segmentControl.addTarget(self, action: "changePicture:", for: UIControlEvents.valueChanged)

        self.view.addSubview(segmentControl)

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.frame = CGRect(x: 50, y: 50, width: 300, height: 400)
        mapView.center.x = CGFloat(screenWidth/2)
        mapView.center.y = CGFloat(screenHeight/2)
        
        self.view.addSubview(mapView)
        setupData()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            let alertController = UIAlertController(title: "Location services were previously denied. Please enable location services for this app in Settings.",
                                                    message: "",
                                                    preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)

        } else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func setupData() {

        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {

            let title = "Taipei 101"
            let coordinate = CLLocationCoordinate2DMake(25.033681, 121.564726)
            let regionRadius = 300.0

            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                         longitude: coordinate.longitude),
                                          radius: regionRadius,
                                          identifier: title)
            locationManager.startMonitoring(for: region)

            let locationAnnotation = MKPointAnnotation()
            locationAnnotation.coordinate = coordinate
            locationAnnotation.title = "\(title)"
            mapView.addAnnotation(locationAnnotation)

            let circle = MKCircle(center: coordinate, radius: regionRadius)
            mapView.add(circle)
        
        } else {
            print("System can't track regions")
        }

    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }

}
