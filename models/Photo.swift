//
//  Photo.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 16/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit
import Photos
import GoogleMaps


struct Photo {
    
    var location: CLLocation
    var date: Date
    var image: UIImage
    var imagePath: String
    
    let photoManager = PHImageManager.default()
    let imageRequestOptions = PHImageRequestOptions()
    
    init(location: CLLocation, date: Date, image: UIImage, imagePath: String) {
        
        self.location = location
        self.date = date
        self.image = image
        self.imagePath = imagePath
    }
    
    func getImage() -> UIImage {
        let asset = getAsset()
        
        return getAssetThumbnail(asset: asset)
    }
    
    func getAsset() -> PHAsset {
        return PHAsset.fetchAssets(withLocalIdentifiers: [self.imagePath], options: PHFetchOptions())[0]
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        
        var image = UIImage()
        imageRequestOptions.isSynchronous = true
        photoManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: imageRequestOptions, resultHandler: {(result, info)->Void in
            image = result!
        })
        return image
    }
}

