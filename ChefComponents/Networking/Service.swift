//
//  Service.swift
//  ChefComponents
//
//  Created by SUNG HAO LIN on 2020/6/22.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

enum DecodableError: Error {
  case decodableFail
}

class Service {

  static let shared = Service()

  // MARK: - Public Methods

  func fetchMask(completion: @escaping ([Pharmacy]?, Error?) -> Void) {
    let maskUrlString = "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json"
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
        let objects = try data!.mapObject(T.self, keyPath: "features")
        completion(objects, nil)
      } catch {
        completion(nil, error)
        print("Failed to decode:", error.localizedDescription)
      }
    }.resume()
  }
}

extension Data {
  func mapObject<T: Decodable>(_ type: T.Type, keyPath: String? = nil) throws -> T {
    let decodable = JSONDecoder()
    guard let keyPath = keyPath else {
      return try decodable.decode(T.self, from: self)
    }

    guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers), let json = jsonObject as? [String: Any], let newValue = json[keyPath] else {
      throw DecodableError.decodableFail
    }

    let data = try JSONSerialization.data(withJSONObject: newValue, options: .fragmentsAllowed)

    return try decodable.decode(T.self, from: data)
  }
}
