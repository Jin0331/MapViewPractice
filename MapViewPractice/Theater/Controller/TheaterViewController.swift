//
//  ViewController.swift
//  MapViewPractice
//
//  Created by JinwooLee on 1/15/24.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var mapView: MKMapView!
    
    var theaterList = TheaterList().mapAnnotations
    var originalTheaterList = TheaterList().mapAnnotations
    let coordinate = CLLocationCoordinate2D(latitude: SetDefaultCoordinate.latitude.rawValue, longitude: SetDefaultCoordinate.longitude.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSegment() // segment 초기화
        
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 15000, longitudinalMeters: 15000), animated: true)
        
        setAnnotation(arrTheater: theaterList)
        
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations) //annotatation 초기화
        
        theaterList = selectType(arrTheater: theaterList, type: sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        
        setAnnotation(arrTheater: theaterList)
        theaterList = originalTheaterList
    }
}

extension TheaterViewController {
    func configureSegment () {
        segmentControl.removeAllSegments() // segment 초기화
        for e in TheaterCase.allCases {
            segmentControl.insertSegment(withTitle: e.index, at: e.rawValue, animated: false)
        }
        
    }
    
    func setAnnotation(arrTheater : [Theater]) {
        for item in arrTheater {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            annotation.title = item.location
            mapView.addAnnotation(annotation)
        }
    }
    
    func selectType(arrTheater : [Theater], type : String) -> [Theater]{
        
        var filteredList : [Theater] = []
        
        if type == TheaterCase.all.index {
            return arrTheater
        } else {
            for item in arrTheater {
                if item.type == type {
                    filteredList.append(item)
                }
            }
            return filteredList
        }
    }
}

