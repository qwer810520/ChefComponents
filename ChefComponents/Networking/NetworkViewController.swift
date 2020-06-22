//
//  NetworkViewController.swift
//  ChefComponents
//
//  Created by SUNG HAO LIN on 2020/6/22.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cyan
    Service.shared.fetchMask { (pharmacies, error) in
      if let error = error {
        print("FetchMask error: ", error.localizedDescription)
      }

      print(">>>>>>>>>> pharmacies count: ", pharmacies?.count)
    }
  }

  // MARK: - Private Methods


}
