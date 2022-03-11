//
//  VerticalCollectionViewFlowLayout.swift
//  iOS
//
//  Created by Roman Baev on 18.05.2020.
//

import UIKit

open class VerticalCollectionViewFlowLayout: UICollectionViewFlowLayout {
  public override init() {
    super.init()
    estimatedItemSize = CGSize(width: 100, height: 200)
    scrollDirection = .vertical
    minimumLineSpacing = 0
    minimumInteritemSpacing = 0
    sectionInset = .zero
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?
      .map({ $0.copy() }) as? [UICollectionViewLayoutAttributes]
    layoutAttributesObjects?.forEach({ layoutAttributes in
      if layoutAttributes.representedElementCategory == .cell {
        if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
          layoutAttributes.frame = newFrame
        }
      }
    })
    return layoutAttributesObjects
  }

  open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?
      .copy() as? UICollectionViewLayoutAttributes
    layoutAttributes?.frame.origin.x = sectionInset.left
    let sectionInsetWidth = sectionInset.left + sectionInset.right
    let itemWidth = collectionView!.safeAreaLayoutGuide.layoutFrame.width - sectionInsetWidth
    layoutAttributes?.frame.size.width = itemWidth
    return layoutAttributes
  }
}
