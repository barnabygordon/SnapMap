//
//  PhotoPickerViewCell.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 22/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit

class PhotoPickerViewCell: UIView {
    
    let imageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let label: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(label)

        transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        setUpImageView()
        setUpLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpImageView() {
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setUpLabel() {
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
