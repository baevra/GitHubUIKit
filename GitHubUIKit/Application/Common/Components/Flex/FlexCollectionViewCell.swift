//
//  FlexCollectionViewCell.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import FlexLayout

open class FlexCollectionViewCell: BaseCollectionViewCell {
  override public func layoutSubviews() {
    super.layoutSubviews()
    layout()
  }

  private func layout() {
    contentView.flex.layout(mode: .adjustHeight)
  }

  override public func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width)
    layout()
    return contentView.frame.size
  }

  open override func layoutMarginsDidChange() {
    super.layoutMarginsDidChange()
    setupSubviews()
  }

  open override func setupSubviews() {
    contentView.subviews.forEach { $0.removeFromSuperview() }
    super.setupSubviews()
  }
}
