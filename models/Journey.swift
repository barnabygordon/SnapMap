//
//  Journe.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 19/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit


struct Journey {
    
    var id: UUID
    var name: String
    var photos: [Photo]
    var mapShot: UIImage
    let dateFormatter = DateFormatter()
    
    init(id: UUID, name: String, photos: [Photo], mapShot: UIImage) {
        
        self.id = id
        self.name = name
        self.photos = photos
        self.mapShot = mapShot
        dateFormatter.dateFormat = "E MMM yy"
    }
    
    func getDateRange() -> String {
        var dates: [Date] = []
        for photo in photos.sorted(by: { ($0.date < $1.date )}) {
            dates.append(photo.date)
        }
        let minDate = dateFormatter.string(from: dates[0])
        let maxDate = dateFormatter.string(from: dates[dates.count - 1])
        
        if minDate != maxDate {
            return "\(minDate)\n-\n\(maxDate)"
        } else {
            return minDate
        }
    }
}


