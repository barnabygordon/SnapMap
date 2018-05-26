//
//  ImagePickerViewController.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 23/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit
import Photos


class ImagePickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var assets: PHFetchResult<AnyObject>?
    let cellId = "cell"
    let dateFormatter = DateFormatter()
    var selectedAssetIndices: [Int] = []
    
    let collectionView: UICollectionView = {
        var view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAssets()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
        collectionView.register(ImagePickerCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        setUpCollectionView()
    }
    
    @objc func handleDone() {
        if selectedAssetIndices.count > 0 {
            print(selectedAssetIndices)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (assets?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImagePickerCollectionViewCell
        cell.backgroundColor = .gray
        selectedAssetIndices = selectedAssetIndices.filter { $0 != indexPath.row }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = assets![indexPath.row] as! PHAsset
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImagePickerCollectionViewCell
        
        if asset.location != nil {
            selectedAssetIndices.append(indexPath.row)
            cell.backgroundColor = .red
        }
        
        print("Location: \(asset.location)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let asset = assets![indexPath.row] as! PHAsset
        let width = (collectionView.bounds.width - 16) / 4
        let size = CGSize(width: width, height: width)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        
        cell.backgroundColor = .black
        
//        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { (image: UIImage?, info: [AnyHashable: Any]?) -> Void in
//            (cell as! ImagePickerCollectionViewCell).imageView.image = image
//        }
        
        if asset.location == nil {
            (cell as! ImagePickerCollectionViewCell).noGPSLabel.text = "No GPS Data"
        }
    }
    
    func getAssets() {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            self.reloadAssets()
        } else {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) in
                if status == .authorized {
                    self.reloadAssets()
                } else {
                    self.showNeedAccessMessage()
                }
            })
        }
    }
    
    
    func showNeedAccessMessage() {
        let alert = UIAlertController(title: "Image picker", message: "App needs access to photos", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
        }))
        
        show(alert, sender: nil)
    }
    
    func reloadAssets() {
        assets = nil
        collectionView.reloadData()
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil) as? PHFetchResult<AnyObject>
        collectionView.reloadData()
    }
    
    func setUpCollectionView() {
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    

}
