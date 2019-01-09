//
//  AuctionBuilder.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 18/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import Foundation

class AuctionBuilder {
  
  private let auctionIdKey = "auc"
  private let itemKey = "item"
  private let ownerKey = "owner"
  private let ownerRealmKey = "ownerRealm"
  private let bidKey = "bid"
  private let buyoutKey = "buyout"
  private let quantityKey = "quantity"
  private let timeLeftKey = "timeLeft"
  private let randKey = "rand"
  private let seedKey = "seed"
  private let contextKey = "context"
  
  func buildAuction(withDictionary dictionary: [String: Any]) -> Auction? {
    if let itemId = dictionary[itemKey] as? Int, let item = Item(rawValue: itemId), let buyoutCopperValue = dictionary[buyoutKey] as? Int, let quantity = dictionary[quantityKey] as? Int, let price = Price(copperValue: buyoutCopperValue) {
      let auction = Auction(item: item, buyoutPrice: price, quantity: quantity)
       return auction
    }
    return nil
  }
  
  func buildAuctions(withArray array: [[String: Any]]) -> [Auction] {
    var auctions = [Auction]()
    for object in array {
      if let auction = self.buildAuction(withDictionary: object) {
        auctions.append(auction)
      }
    }
    return auctions
  }
}
