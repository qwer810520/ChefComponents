//
//  Pharmacy.swift
//  ChefComponents
//
//  Created by SUNG HAO LIN on 2020/6/22.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

struct Pharmacy: Codable, Equatable {
  let id: String?
  let name: String?
  let phone: String?
  let address: String?
  let maskAdult: Int?
  let maskChild: Int?
  let updated: String?
  let available: String?
  let note: String?
  let customNote: String?
  let website: String?
  let county: String?
  let town: String?
  let cunli: String?
  let servicePeriods: String?
  let coordinates: [Double]?

  enum BaseKeys: String, CodingKey {
    case properties
    case geometry
  }

  enum PropertiesKeys: String, CodingKey {
    case id
    case name
    case phone
    case address
    case maskAdult = "mask_adult"
    case maskChild = "mask_child"
    case updated
    case available
    case note
    case customNote = "custom_note"
    case website
    case county
    case town
    case cunli
    case servicePeriods = "service_periods"
  }

  enum GeometryKeys: String, CodingKey {
    case coordinates
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: BaseKeys.self)
    let properties = try container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
    id = try properties.decodeIfPresent(String.self, forKey: .id)
    name = try properties.decodeIfPresent(String.self, forKey: .name)
    phone = try properties.decodeIfPresent(String.self, forKey: .phone)
    address = try properties.decodeIfPresent(String.self, forKey: .address)
    maskAdult = try properties.decodeIfPresent(Int.self, forKey: .maskAdult)
    maskChild = try properties.decodeIfPresent(Int.self, forKey: .maskChild)
    updated = try properties.decodeIfPresent(String.self, forKey: .updated)
    available = try properties.decodeIfPresent(String.self, forKey: .available)
    note = try properties.decodeIfPresent(String.self, forKey: .note)
    customNote = try properties.decodeIfPresent(String.self, forKey: .customNote)
    website = try properties.decodeIfPresent(String.self, forKey: .website)
    county = try properties.decodeIfPresent(String.self, forKey: .county)
    town = try properties.decodeIfPresent(String.self, forKey: .town)
    cunli = try properties.decodeIfPresent(String.self, forKey: .cunli)
    servicePeriods = try properties.decodeIfPresent(String.self, forKey: .servicePeriods)
    let geometry = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
    coordinates = try geometry.decodeIfPresent([Double].self, forKey: .coordinates)
  }
}

/*

 {
   "type": "FeatureCollection",
   "features": [ // -----> Key 值
     {
       "type": "Feature",
       "properties": {
         "id": "5945030094",
         "name": "德興藥局",
         "phone": "03-8889408",
         "address": "花蓮縣玉里鎮國武里中山路２段５８號",
         "mask_adult": 2529,
         "mask_child": 486,
         "updated": "2020/05/21 14:23:32",
         "available": "星期一上午看診、星期二上午看診、星期三上午看診、星期四上午看診、星期五上午看診、星期六上午看診、星期日上午看診、星期一下午看診、星期二下午看診、星期三下午看診、星期四下午看診、星期五下午看診、星期六下午看診、星期日下午看診、星期一晚上看診、星期二晚上看診、星期三晚上看診、星期四晚上看診、星期五晚上看診、星期六晚上看診、星期日晚上看診",
         "note": "口罩販售，平常日下午一點開始，周日下午三點開始，成人口罩200份，兒童口罩20份，售完為止。",
         "custom_note": "",
         "website": "",
         "county": "花蓮縣",
         "town": "玉里鎮",
         "cunli": "國武里",
         "service_periods": "NNNNNNNNNNNNNNNNNNNNN"
       },
       "geometry": { // -----> Key 值
         "type": "Point",
         "coordinates": [
           121.315149,
           23.333096
         ]
       }
     }
   ]
 }

 */
