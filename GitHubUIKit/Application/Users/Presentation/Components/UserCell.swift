//
//  UserCell.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import UIKit
import FlexLayout

final class UserCell: FlexTableViewCell {
  let loginLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 0
    return label
  }()

  func configure(_ user: User) {
    loginLabel.text = user.login
  }

  override func setupSubviews() {
    super.setupSubviews()
    contentView.flex
      .padding(layoutMargins)
      .define {
        $0.addItem()
          .direction(.column)
          .define {
            $0.addItem(loginLabel)
          }
      }
  }
}
