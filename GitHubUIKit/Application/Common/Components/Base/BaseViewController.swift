//
//  BaseViewController.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import RxSwift
import FlexLayout
import PinLayout

open class BaseViewController<View: UIView>: UIViewController {
  public var disposeBag = DisposeBag()

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable) public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func loadView() {
    view = View()
    if let flexView = view as? FlexView {
      flexView.layoutMode = .fitContainer
    }
  }

  open override func viewDidLoad() {
    super.viewDidLoad()
    let view = self.view as! View
    setupView(view: view)
    bindViewModel(view: view)
    bindView(view: view)
  }

  open func bindViewModel(view: View) {}
  open func bindView(view: View) {}
  open func setupView(view: View) {}
}
