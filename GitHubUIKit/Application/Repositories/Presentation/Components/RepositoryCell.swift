//
//  RepositoryCell.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit
import FlexLayout

public final class RepositoryCell: FlexCollectionViewCell {
  public let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 0
    return label
  }()

  public let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    return label
  }()

  public let starsCountLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .footnote)
    return label
  }()

  public let forksCountLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .footnote)
    return label
  }()

  public let divider: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
    return view
  }()

  public func configure(_ viewModel: RepositoryCellViewModel) {
    nameLabel.text = viewModel.name
    descriptionLabel.text = viewModel.description
    updateStarsCount(viewModel.starsCount)
    updateForksCount(viewModel.forksCount)
  }

  public func updateStarsCount(_ count: Int) {
    starsCountLabel.text = "⭐️ \(count)"
    starsCountLabel.flex.markDirty()
    setNeedsLayout()
  }

  public func updateForksCount(_ count: Int) {
    forksCountLabel.text = "🔄 \(count)"
    forksCountLabel.flex.markDirty()
    setNeedsLayout()
  }

  public override func setupSubviews() {
    super.setupSubviews()
    contentView.flex
      .define {
        $0.addItem()
          .direction(.column)
          .padding(layoutMargins)
          .define {
            $0.addItem(nameLabel)
            $0.addItem(descriptionLabel)
              .marginTop(4)
            $0.addItem()
              .direction(.column)
              .marginTop(6)
              .define {
                $0.addItem(starsCountLabel)
                $0.addItem(forksCountLabel)
                  .marginTop(4)
              }
          }
        $0.addItem(divider)
          .marginLeft(layoutMargins.left)
          .height(0.5)
      }
  }
}
