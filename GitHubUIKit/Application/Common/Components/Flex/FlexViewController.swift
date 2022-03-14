//
//  FlexViewController.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import RxSwift
import FlexLayout
import PinLayout

open class FlexViewController: BaseViewController<UIView> {
  public let contentView = UIView()

  open override func viewDidLoad() {
    view.addSubview(contentView)
    super.viewDidLoad()
  }

  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    contentView.pin.all()
    contentView.flex.layout()
  }
}
