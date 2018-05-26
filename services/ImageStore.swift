//
//  ImageStore.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 20/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit


class ImageStore: NSObject {
    
    func saveImage(by journey_id: UUID, image: UIImage) -> Bool {
        guard let data = UIImageJPEGRepresentation(image, 1) ?? UIImagePNGRepresentation(image) else {
            return false
        }
        
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else { return false}
        
        do {
            try data.write(to: directory.appendingPathComponent(journey_id.uuidString)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getImage(by journey_id: UUID) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(journey_id.uuidString).path)
        }
        return nil
    }
}
