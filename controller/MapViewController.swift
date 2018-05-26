//
//  MapViewController.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 16/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps


class MapViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var photos: [Photo]?
    var journeyName: String?
    var allowSave: Bool?
    let dateFormatter = DateFormatter()
    
    let photoSwipeView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoPickerView: UIPickerView = {
        var view = UIPickerView()
        view.transform = CGAffineTransform(rotationAngle: -90 * (.pi/180))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mapView: MapView = {
        var map = MapView.map(withFrame: .zero, camera: GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 1))
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    override func viewDidLoad() {

        dateFormatter.dateFormat = "E MMM yy HH:mm"
        
        photoPickerView.dataSource = self
        photoPickerView.delegate = self

        view.addSubview(mapView)
        view.addSubview(photoSwipeView)
        view.addSubview(photoPickerView)
        
        setUpPhotoSwipeView()
        setUpPhotoPickerView()
        setUpMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appearing...")
        photoPickerView.reloadAllComponents()
        photoPickerView.selectRow(0, inComponent: 0, animated: false)
        if allowSave == true {
            navigationItem.title = "Photos"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveJourney))
        } else {
            navigationItem.title = journeyName
            navigationItem.rightBarButtonItem = nil
        }

        if photos != nil {
            sortPhotos()
            mapView.plotPhotos(photos: photos!)
            mapView.fitToPhoto(photo: photos![0])
        } else { print("No photos set...") }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (photos?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 350
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 300
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        print("Sliding to photo: \(row)")
        let photo = photos![row]
        
        let view = PhotoPickerViewCell()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 350)
        view.imageView.image = photo.image
        view.label.text = dateFormatter.string(from: photo.date)
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let photo = photos![row]
        mapView.fitToPhoto(photo: photo)
    }
    
    @objc func saveJourney() {

        UIGraphicsBeginImageContext(mapView.frame.size);
        mapView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let snapShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let alert = UIAlertController(title: "Journey Name", message: "Choose a name for the journey", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "A fun day out"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let journeyName = textField?.text
            
            JourneyRepository().saveJourney(photos: self.photos!, snapShot: snapShot!, journeyName: journeyName!)
            
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func sortPhotos() {
        photos = photos?.sorted(by: { ($0.date < $1.date )})
    }

    func setUpMapView() {
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: photoSwipeView.topAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    func setUpPhotoSwipeView() {
        photoSwipeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photoSwipeView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        photoSwipeView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setUpPhotoPickerView() {
        photoPickerView.heightAnchor.constraint(equalTo: photoSwipeView.widthAnchor).isActive = true
        photoPickerView.widthAnchor.constraint(equalTo: photoSwipeView.heightAnchor).isActive = true
        photoPickerView.centerXAnchor.constraint(equalTo: photoSwipeView.centerXAnchor).isActive = true
        photoPickerView.centerYAnchor.constraint(equalTo: photoSwipeView.centerYAnchor).isActive = true
    }
}
