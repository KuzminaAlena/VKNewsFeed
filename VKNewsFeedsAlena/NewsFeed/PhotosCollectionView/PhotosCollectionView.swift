//
//  PhotosCollectionView.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 14.03.2022.
//

import Foundation
import UIKit

class PhotosCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    var photos = [FeedCellPhotoAttachmentsViewModel]()
    
    init() {
        let customLayout = CustomLayout()
        super.init(frame: .zero, collectionViewLayout: customLayout)
        
        delegate = self
        dataSource = self
        
        backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseId)
        
        if let customLayout = collectionViewLayout as? CustomLayout {
            customLayout.delegate = self
        }
    }
    
    func set(photos: [FeedCellPhotoAttachmentsViewModel]) {
        self.photos = photos
        contentOffset = CGPoint.zero
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseId, for: indexPath) as! PhotosCollectionViewCell
        cell.set(imageURL: photos[indexPath.row].photoURLString)
        return cell
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotosCollectionView: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
