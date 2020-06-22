//
//  CollectionViewController.swift
//  ChefComponents
//
//  Created by SUNG HAO LIN on 2020/6/22.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit
import SnapKit

class CollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

  private let cellId = "cellId"

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
    collectionView.backgroundColor = .systemGray2
    return collectionView
  }()

  lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15) // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
    flowLayout.minimumLineSpacing = 25 // 設置每一行的間距
    
    return flowLayout
  }()

  var color: [UIColor] = [.red, .cyan, .green, .purple, .yellow, .blue]
  var size: [CGSize] = [.init(width: 5, height: 5),
                        .init(width: -5, height: 5),
                        .init(width: 5, height: -5),
                        .init(width: -5, height: -5),
                        .init(width: 5, height: 0),
                        .init(width: 0, height: -5)
  ]

  // MARK: - Initialization

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setupSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.register(DemoCell.self, forCellWithReuseIdentifier: cellId)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? DemoCell else {
      fatalError("Cell Error")
    }
    let cellColor = color[indexPath.row]
    let cellShadowOffset = size[indexPath.row]

    cell.view.backgroundColor = cellColor
    cell.view.layer.shadowColor = UIColor.black.cgColor // 設定陰影顏色
    cell.view.layer.shadowOpacity = 0.5 // 設定透明度
    cell.view.layer.shadowOffset = cellShadowOffset // 設置陰影偏移量
    cell.view.layer.shadowRadius = 5 // 設定陰影半徑
    cell.label.text = "(\(cellShadowOffset.width), \(cellShadowOffset.height))"
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: 180, height: 180) // 設定 cell size
  }

  // MARK: - Private Methods

  private func setShadow(view: UIView, color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) {
    view.layer.shadowColor = color.cgColor // 設定陰影顏色
    view.layer.shadowOpacity = opacity // 設定透明度
    view.layer.shadowRadius = radius // 設定陰影半徑
    view.layer.shadowOffset = offset // 設置陰影偏移量
  }

  private func setupSubviews() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.size.equalToSuperview()
    }
  }
}

class DemoCell: UICollectionViewCell {

  lazy var view: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    return view
  }()

  lazy var label: UILabel = {
    let label = UILabel()
    label.text = "12"
    label.textAlignment = .center
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    view.addSubview(label)
    contentView.addSubview(view)

    label.snp.makeConstraints {
      $0.width.equalToSuperview()
      $0.height.equalTo(30)
      $0.centerX.centerY.equalToSuperview()
    }

    view.snp.makeConstraints {
      $0.size.equalToSuperview()
    }
  }
}
