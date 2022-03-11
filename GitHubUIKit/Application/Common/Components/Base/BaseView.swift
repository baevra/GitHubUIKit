//
//  BaseView.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit

open class BaseView: UIView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
  }

  @available(*, unavailable) public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupSubviews()
  }

  open func setupSubviews() {
    backgroundColor = .white
  }

  open override func layoutMarginsDidChange() {
    super.layoutMarginsDidChange()
//    setupSubviews()
  }
}
