//
//  Service.swift
//  ChefComponents
//
//  Created by SUNG HAO LIN on 2020/6/22.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

class Service {

  static let shared = Service()

  // MARK: - Public Methods

  func fetchMask(completion: @escaping ([Pharmacy]? , Error?) -> Void) {
    let maskUrlString = "https://raw.githubusercontent.com/"
    fetchGenericJSONData(urlString: maskUrlString, completion: completion)
  }

  // MARK: - Private Methods

  // declare generic json function
  private func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
    guard let url = URL(string: urlString) else { return }

    print("T's type is: ", T.self)

    URLSession.shared.dataTask(with: url) { (data, res, error) in
      if let error = error {
        completion(nil, error)
      }

      do {
        let objects = try JSONDecoder().decode(T.self, from: data!)
        completion(objects, nil)
      } catch {
        completion(nil, error)
        print("Failed to decode:", error.localizedDescription)
      }
    }.resume()
  }
}
