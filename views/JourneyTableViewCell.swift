//
//  JourneyTableViewCell.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 19/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit


class JourneyTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dateLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let mapImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let rightArrowImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "right")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CoreColour.red
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowRadius = 1
        
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(mapImage)
        containerView.addSubview(rightArrowImage)

        setupContainerView()
        setUpMapImage()
        setUpTitleLabel()
        setUpDateLabel()
        setUpRightArrowImage()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContainerView() {
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }

    func setUpTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mapImage.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setUpDateLabel() {
        dateLabel.leftAnchor.constraint(equalTo: mapImage.rightAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setUpMapImage() {
        mapImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        mapImage.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        mapImage.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        mapImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.333).isActive = true
    }
    
    func setUpRightArrowImage() {
        rightArrowImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        rightArrowImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        rightArrowImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4).isActive = true
        rightArrowImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
