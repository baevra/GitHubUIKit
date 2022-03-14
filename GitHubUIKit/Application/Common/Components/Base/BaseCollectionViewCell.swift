//
//  BaseCollectionViewCell.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupSubviews()
  }

  open func setupSubviews() {}

  open override func layoutMarginsDidChange() {
    super.layoutMarginsDidChange()
    setupSubviews()
  }
}
