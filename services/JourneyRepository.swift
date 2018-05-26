//
//  JourneyRepository.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 19/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import CoreData
import GoogleMaps
import UIKit
import Photos


class JourneyRepository: NSObject {
    
    var context: NSManagedObjectContext
    var photoEntity: NSEntityDescription
    var journeyEntity: NSEntityDescription
    
    let coreJourney: String = "CoreJourney"
    let corePhoto: String = "CorePhoto"
    
    override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        photoEntity = NSEntityDescription.entity(forEntityName: corePhoto, in: context)!
        journeyEntity = NSEntityDescription.entity(forEntityName: coreJourney, in: context)!
    }
    
    func saveJourney(photos: [Photo], snapShot: UIImage, journeyName: String) {
        let journeyUUID = UUID()
        
        for photo in photos {
            savePhoto(photo: photo, journeyUUID: journeyUUID)
        }
        
        let newJourney = NSManagedObject(entity: journeyEntity, insertInto: context)
        newJourney.setValue(journeyUUID, forKey: "id")
        newJourney.setValue(journeyName, forKey: "name")
        
        save()
        ImageStore().saveImage(by: journeyUUID, image: snapShot)
        print("Saved \(photos.count) photo(s).")
    }
    
    func savePhoto(photo: Photo, journeyUUID: UUID) {
        
        let newPhoto = NSManagedObject(entity: photoEntity, insertInto: context)
        
        newPhoto.setValue(photo.location.coordinate.latitude, forKey: "latitude")
        newPhoto.setValue(photo.location.coordinate.longitude, forKey: "longitude")
        newPhoto.setValue(journeyUUID, forKey: "journey_id")
        newPhoto.setValue(photo.date, forKey: "date")
        newPhoto.setValue(photo.imagePath, forKey: "path")
    }
    
    func getAllJourneys() -> [Journey] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: coreJourney)
        request.returnsObjectsAsFaults = false
        var journeys: [Journey] = []
        do {
            let result = try context.fetch(request)
            print("Found \(result.count) saved journeys.")
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! UUID
                let name = data.value(forKey: "name") as! String
                let photos = getPhotosByJourneyId(journeyId: id)
                
                var mapShot = ImageStore().getImage(by: id)
                if mapShot == nil {
                    mapShot = UIImage(named: "cogwheel")
                }
                
                journeys.append(Journey(id: id, name: name, photos: photos, mapShot: mapShot!))
            }
            
        } catch {
            print("Failed")
        }
        return journeys
    }
    
    func getPhotosByJourneyId(journeyId: UUID) -> [Photo] {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: corePhoto)
        request.predicate = NSPredicate(format: "journey_id = %@", journeyId as NSUUID)
        request.returnsObjectsAsFaults = false
        var photos: [Photo] = []
        do {
            let result = try context.fetch(request)
            print("Found \(result.count) saved photos.")
            for data in result as! [NSManagedObject] {
                
                let latitude = data.value(forKey: "latitude") as! Double
                let longitude = data.value(forKey: "longitude") as! Double
                let date = data.value(forKey: "date") as! Date
                let path = data.value(forKey: "path") as! String
                let location = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
                
                let asset = PHAsset.fetchAssets(withLocalIdentifiers: [path], options: PHFetchOptions()).firstObject
                let image = getAssetThumbnail(asset: asset!)
                photos.append(Photo(location: location, date: date, image: image, imagePath: path))
            }
        } catch {
            print("Failed")
        }
        return photos
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    

}
