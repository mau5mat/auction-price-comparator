//
//  Auctions.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 16/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import Foundation

struct Auction {
  
  enum TimeLeft: String {
    case veryLong = "VERY_LONG"
    case long = "LONG"
    case medium = "MEDIUM"
    case short = "SHORT"
  }
  
//  let auctionID: Int
  let item: Item
//  let owner: String
//  let ownerRealm: String
//  let bid: Int
  let buyoutPrice: Price
  let quantity: Int
//  let timeLeft: TimeLeft
//  let rand: Int?
//  let seed: Int?
//  let context: Int?
  
  init(item: Item, buyoutPrice: Price, quantity: Int) {
    self.item = item
    self.buyoutPrice = buyoutPrice
    self.quantity = quantity
  }
}

