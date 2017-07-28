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
    let segmentControl = UISegmentedControl(items: [ "我的位置", "台北101", "臨江夜市", "世貿三館", "大安公園"])
    var mapView = MKMapView()
    var myLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        segmentControl.frame = CGRect(x: 50, y: 50, width: 300, height: 30)
        segmentControl.center.x = CGFloat(screenWidth/2)
        segmentControl.center.y = CGFloat(screenHeight/6)
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.addTarget(self, action: #selector(changeLoction), for: UIControlEvents.valueChanged)
        
        self.view.addSubview(segmentControl)
        
        locationManager.delegate = self
        //距離篩選器
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        //精确度最佳
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.frame = CGRect(x: 50, y: 50, width: 300, height: 400)
        mapView.center.x = CGFloat(screenWidth/2)
        mapView.center.y = CGFloat(screenHeight/2)
        
        self.view.addSubview(mapView)
        
        //檢查系統是否能夠監視 region
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
        } else {
            
            print("Can't Monitor")
            
        }
        
        setupAnnotation(title:"台北 101", latitude:25.033681, longitude:121.564726)
        setupAnnotation(title:"臨江夜市", latitude:25.030207685924424, longitude:121.55425105092706)
        setupAnnotation(title:"世貿三館", latitude:25.03568611822103, longitude:121.56451985004946)
        setupAnnotation(title:"大安森林公園", latitude:25.032356284593394, longitude:121.53488758316053)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            
            locationManager.requestAlwaysAuthorization()
            
        } else if CLLocationManager.authorizationStatus() == .denied {
            
            print("Denied")
            
        } else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        myLocation = center
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func setupAnnotation(title: String, latitude: Float, longitude: Float) {
        
        let title = title
        let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
        let regionRadius = 200.0
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
            
            let viewRegion = MKCoordinateRegionMakeWithDistance(myLocation, 200, 200)
            mapView.setRegion(viewRegion, animated: false)
            
        case 1:
            
            let noLocation = CLLocationCoordinate2DMake(25.033681, 121.564726)
            let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
            mapView.setRegion(viewRegion, animated: false)
            
        case 2:
            
            let noLocation = CLLocationCoordinate2DMake(25.030207685924424, 121.55425105092706)
            let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
            mapView.setRegion(viewRegion, animated: false)
            
        case 3:
            
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
