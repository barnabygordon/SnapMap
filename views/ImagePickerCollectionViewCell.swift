//
//  ImagePickerCollectionViewCell.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 23/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit


class ImagePickerCollectionViewCell: UICollectionViewCell {
        
    let imageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let noGPSLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectedIcon: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(noGPSLabel)
        addSubview(selectedIcon)
        
        setUpImageView()
        setUpNoGPSLabel()
        setUpSelectedIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpImageView() {
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setUpNoGPSLabel() {
        noGPSLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        noGPSLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noGPSLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        noGPSLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setUpSelectedIcon() {
        selectedIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectedIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        selectedIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

