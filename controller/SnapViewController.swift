//
//  SnapViewController.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 12/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit
import CoreData
import DKImagePickerController


class SnapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var journeys: [Journey] = []
    let cellId = "cell"
    let mapViewController = MapViewController()
    
    let journeyTableView: UITableView = {
        var view = UITableView()
        view.rowHeight = 140
        view.backgroundColor = CoreColour.lightRed
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(getPhotos))
        navigationItem.rightBarButtonItem = backButton
        navigationController?.navigationBar.barTintColor = CoreColour.red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationItem.title = "Journeys"
        
        view.backgroundColor = .white
        journeyTableView.separatorStyle = .none
        journeyTableView.dataSource = self
        journeyTableView.delegate = self
        journeyTableView.register(JourneyTableViewCell.self, forCellReuseIdentifier: cellId)
        
        view.addSubview(journeyTableView)

        setupJourneyTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        journeys = JourneyRepository().getAllJourneys()
        journeyTableView.reloadData()
    }
    
    @objc func getPhotos() {
        navigationController?.pushViewController(ImagePickerViewController(), animated: true)
    }
    
    @objc func getPhotosOld() {
        
        let pickerController = DKImagePickerController()
        pickerController.showsCancelButton = true
        pickerController.sourceType = .photo
        pickerController.assetType = .allPhotos
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            var photos: [Photo] = []
            for asset in assets {
                
                asset.fetchImageWithSize(CGSize.init(width: 200, height: 200), completeBlock: {image, info in
                    
                    if asset.location != nil && asset.originalAsset?.creationDate != nil && image != nil {
                        photos.append(Photo(
                            location: asset.location!,
                            date: (asset.originalAsset?.creationDate)!,
                            image: image!,
                            imagePath: asset.localIdentifier))
                    } else {
                        print("Bad photo")
                    }
                })
            }
            
            self.showToast(message: "Found \(photos.count) photos")
            
            if photos.count > 0 {
                print("Setting photos..")
                self.mapViewController.photos = photos
                self.mapViewController.allowSave = true
                self.navigationController?.pushViewController(self.mapViewController, animated: true)
            }
        }
        
        self.present(pickerController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = journeyTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! JourneyTableViewCell
        let journey = journeys[indexPath.row]
        
        let dateText = journey.getDateRange()
        
        cell.titleLabel.text = journey.name
        cell.dateLabel.text = dateText
        cell.mapImage.image = journey.mapShot
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journey = journeys[indexPath.row]
        print("Seeting photos..")
        mapViewController.photos = journey.photos
        mapViewController.journeyName = journey.name
        mapViewController.allowSave = false
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    func setupJourneyTableView() {
        journeyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        journeyTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        journeyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
