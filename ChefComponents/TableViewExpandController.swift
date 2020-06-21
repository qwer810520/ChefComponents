//
//  TableViewExpandController.swift
//  ChefComponents
//
//  Created by SUNG HAO LIN on 2020/6/21.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class TableViewExpandController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  private var cellId = "cellID"
  private var headerExpandStatus = [false, false]

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: view.bounds)
    tableView.separatorStyle = .none
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    return tableView
  }()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    setupSubviews()
  }

  // MARK: - UITableViewDelegate

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard section <= 1 else {
      let view = UIView()
      view.backgroundColor = .red
      return view
    }

    let button = UIButton(type: .system)
    button.setTitle("Header with Section: \(section)", for: .normal)
    button.tag = section
    button.addTarget(self, action: #selector(headerButtonDidPressed(_:)), for: .touchUpInside)
    return button
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You did select row is: \(indexPath.row)")
    tableView.deselectRow(at: indexPath, animated: true)
  }

  // MARK: - UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard section <= 1 else { return 0 }
    return headerExpandStatus[section] ? 5 : 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
      fatalError("UITableViewCell Initialization Fail")
    }
    cell.textLabel?.text = "row is \(indexPath.row)"
    return cell
  }


  // MARK: - Private Methods

  private func setupSubviews() {
    view.addSubview(tableView)
  }

  @objc private func headerButtonDidPressed(_ button: UIButton) {
    switch button.tag {
      case 0, 1:
        headerExpandStatus[button.tag] = !headerExpandStatus[button.tag]
        tableView.reloadSections(IndexSet(integer: button.tag), with: .automatic)
      default: break
    }
  }
}
