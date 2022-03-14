//
//  FlexView.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import FlexLayout
import PinLayout

open class FlexView: BaseView {
  public let contentView = UIView()
  open var layoutMode: Flex.LayoutMode = .adjustHeight {
    didSet {
      setNeedsLayout()
    }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubviews()
  }

  open override func setupSubviews() {
    contentView.backgroundColor = .clear
    addSubview(contentView)
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    switch layoutMode {
    case .adjustHeight:
      contentView.pin.width(frame.width)
      layout()
    case .adjustWidth:
      contentView.pin.height(frame.height)
      layout()
    case .fitContainer:
      contentView.pin.all()
      layout()
    }
  }

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    switch layoutMode {
    case .adjustHeight:
      contentView.pin.width(frame.width)
      layout()
    case .adjustWidth:
      contentView.pin.height(frame.height)
      layout()
    case .fitContainer:
      contentView.pin.all()
      layout()
    }
    return contentView.frame.size
  }

  private func layout() {
    contentView.flex.layout(mode: layoutMode)
  }
}
