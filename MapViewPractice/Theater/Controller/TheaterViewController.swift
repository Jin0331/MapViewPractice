//
//  ViewController.swift
//  MapViewPractice
//
//  Created by JinwooLee on 1/15/24.
//

import UIKit
import CoreLocation
import MapKit

class TheaterViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var filterButton: UIButton!
    
    // location manager
    let locationManager = CLLocationManager()
    
    var theaterList = TheaterList().mapAnnotations
    var originalTheaterList = TheaterList().mapAnnotations
    
//    let coordinate = CLLocationCoordinate2D(latitude: SetDefaultCoordinate.latitude.rawValue, longitude: SetDefaultCoordinate.longitude.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        checkDeviceLocationAuthorization()
        
//        setAnnotation(arrTheater: theaterList)
        
    }
}

//MARK: - Class Function
extension TheaterViewController {
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            
            if CLLocationManager.locationServicesEnabled() {
                let authorization : CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                // 사용자가 위치 정보를 승인하지 않은 경우
                print("위치 서비스가 꺼져있다. 권한 요청할 수 없음")
            }
        }
    } // function end
    
    func checkCurrentLocationAuthorization(status : CLAuthorizationStatus) {
        print(#function)
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showLocationSettingAlert()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default :
            print("Error")
        }
    } // function end
    
    
    // 사용자가 앱에 처음 접근시 나타나는 Alert임
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(goSetting)
        present(alert, animated: true)
    } // function end
    
    
    // 사용자의 위치 기반으로, MapView에 띄움
    func setRegionAndAnnotation(center : CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
    } // function end
}

//MARK: - Location 관련
extension TheaterViewController : CLLocationManagerDelegate {
    
    // 사용자의 위치를 가져오는데 성공한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            // mapView의 default region 띄우는 function 호출
            setRegionAndAnnotation(center: coordinate)
        }
        
        // 사용자의 위치 업데이트 중지..
        //TODO: - 아래의 코드 사용시 위치 업데이트는 앱 실행시 한번 또는 앱을 재시작할때마다
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error - ", #function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization() // switch 문으로 돌아감
    }
    
}









//
//
//
//
////MARK: - MapView 관련
//extension TheaterViewController {
//    func configureButton () {
//        
//    }
//    
//    func setAnnotation(arrTheater : [Theater]) {
//        for item in arrTheater {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
//            annotation.title = item.location
//            mapView.addAnnotation(annotation)
//        }
//    }
//    
//    func selectType(arrTheater : [Theater], type : String) -> [Theater]{
//        
//        var filteredList : [Theater] = []
//        
//        if type == TheaterCase.all.index {
//            return arrTheater
//        } else {
//            for item in arrTheater {
//                if item.type == type {
//                    filteredList.append(item)
//                }
//            }
//            return filteredList
//        }
//    }
//}
//
