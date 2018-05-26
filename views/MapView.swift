//
//  MapView.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 20/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit
import GoogleMaps


class MapView: GMSMapView {
    
    let dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func plotPhotos(photos: [Photo]) {
        clear()

        for photo in photos {
            
            let marker = GMSMarker(position: photo.location.coordinate)
            marker.title = dateFormatter.string(from: photo.date)
            marker.map = self
        }
        
        let polyLine = getPolyLineFromPhotos(photos: photos)
        plotPolyLine(polyLine: polyLine)
        
        animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(path: polyLine.path!)))
    }
    
    func getPolyLineFromPhotos(photos: [Photo]) -> GMSPolyline {
        let path = GMSMutablePath()
        
        for photo in photos {
            path.add(photo.location.coordinate)
        }
        
        return GMSPolyline(path: path)
    }
    
    func fitToPhoto(photo: Photo) {
        let bounds = GMSCoordinateBounds()
        bounds.includingCoordinate(photo.location.coordinate)
        
        animate(toLocation: photo.location.coordinate)
        
        //animate(with: GMSCameraUpdate.fit(bounds, withPadding: CGFloat(15)))
    }
    
    func plotPolyLine(polyLine: GMSPolyline) {
        polyLine.map = self
    }


}
