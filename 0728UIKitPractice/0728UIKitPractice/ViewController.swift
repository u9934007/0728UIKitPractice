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

        segmentControl.addTarget(self, action: #selector(changeLoction), for: UIControlEvents.valueChanged)

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
        setupData(title:"台北 101", latitude:25.033681, longitude:121.564726)
        setupData(title:"臨江夜市", latitude:25.030207685924424, longitude:121.55425105092706)
        setupData(title:"世貿三館", latitude:25.03568611822103, longitude:121.56451985004946)
        setupData(title:"大安森林公園", latitude:25.032356284593394, longitude:121.53488758316053)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if CLLocationManager.authorizationStatus() == .notDetermined {

            locationManager.requestAlwaysAuthorization()

        } else if CLLocationManager.authorizationStatus() == .denied {

            let alertController = UIAlertController(title: "Location services were previously denied.",
                                                    message: "",
                                                    preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)

        } else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func setupData(title: String, latitude: Float, longitude: Float) {

        //檢查系統是否能夠監視 region
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {

            let title = title
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
            let regionRadius = 300.0
            let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                         longitude: coordinate.longitude),
                                          radius: regionRadius,
                                          identifier: title)
            locationManager.startMonitoring(for: region)

            //創建大頭釘
            let locationAnnotation = MKPointAnnotation()
            locationAnnotation.coordinate = coordinate
            locationAnnotation.title = "\(title)"
            mapView.addAnnotation(locationAnnotation)

            //在Region上畫圈圈
            let circle = MKCircle(center: coordinate, radius: regionRadius)
            mapView.add(circle)

        } else {

            print("System can't track regions")

        }

    }

    //繪製圓圈
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer

    }

    func changeLoction(sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {

        case 0:
            let noLocation = CLLocationCoordinate2DMake(25.033681, 121.564726)

            let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
            mapView.setRegion(viewRegion, animated: false)

        case 1:
            let noLocation = CLLocationCoordinate2DMake(25.030207685924424, 121.55425105092706)
            let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
            mapView.setRegion(viewRegion, animated: false)

        case 2:
            let noLocation = CLLocationCoordinate2DMake(25.03568611822103, 121.56451985004946)
            let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
            mapView.setRegion(viewRegion, animated: false)

        default:
            let noLocation = CLLocationCoordinate2DMake(25.032356284593394, 121.53488758316053)
            let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
            mapView.setRegion(viewRegion, animated: false)

        }

    }

}
