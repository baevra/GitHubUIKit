//
//  BaseTableView.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit

open class BaseTableView: UITableView {
  public init(style: Style = .plain) {
    super.init(frame: .zero, style: style)
    rowHeight = UITableView.automaticDimension
    estimatedRowHeight = 48
    tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNormalMagnitude))
    tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNormalMagnitude))
    sectionFooterHeight = 0
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
