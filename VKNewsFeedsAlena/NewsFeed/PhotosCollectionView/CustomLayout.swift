//
//  CustomLayout.swift
//  VKNewsFeedsAlena
//
//  Created by Алена on 15.03.2022.
//

import Foundation
import UIKit

protocol CustomLayoutDelegate: AnyObject {

    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}


class CustomLayout : UICollectionViewLayout {
    
    weak var delegate: CustomLayoutDelegate!
    
    static var numberOfRowsLayout = 1
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeight: CGFloat {
        
        guard let collectionView = collectionView else { return 0 }
        
        let insets = collectionView.contentInset
        
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight )
    }
    
    override func prepare() {
        
        contentWidth = 0
        cache = []
        
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let superViewWidth = collectionView.frame.width
        
        guard var rowHeight = CustomLayout.rowHeighCalculator(superViewWidth: superViewWidth, photosArray: photos) else { return }
         
        rowHeight = rowHeight / CGFloat(CustomLayout.numberOfRowsLayout)
        
        let photosSizeRatio = photos.map { $0.height / $0.width }
        
        var yOffset = [CGFloat]()
        for row in 0 ..< CustomLayout.numberOfRowsLayout {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        
        var xOffset = [CGFloat](repeating: 0, count: CustomLayout.numberOfRowsLayout)
        var row = 0
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let ratio = photosSizeRatio[indexPath.row]
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = insetFrame
            cache.append(attribute)
            
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] = xOffset[row] + width
            row = row < (CustomLayout.numberOfRowsLayout - 1) ? (row + 1) : 0
        }
        
    }
    
    static func rowHeighCalculator(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        
        var rowheight: CGFloat
        
        let photoWidthMinRatio = photosArray.min { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }
        
        guard let myPhotoWidthMinRatio = photoWidthMinRatio else { return nil }
        
        let difference = superViewWidth / myPhotoWidthMinRatio.width
        
        rowheight = myPhotoWidthMinRatio.width * difference
        
        rowheight = rowheight * CGFloat(CustomLayout.numberOfRowsLayout)
        return rowheight
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
