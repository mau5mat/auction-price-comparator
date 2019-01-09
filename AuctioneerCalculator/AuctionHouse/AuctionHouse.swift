//
//  AuctionHouse.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 20/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import Foundation

protocol AuctionHouseDelegate {
  func auctionHouse(_ auctionHouse: AuctionHouse, receivedAuctions auctions: [Auction])
}

class AuctionHouse: WebRequestServiceDelegate {
  
  private let webService = WebRequestService()
  
  let locale: Locale
  let realm: Realm
  
  var auctions: [Auction]?
  var delegate: AuctionHouseDelegate?
  
  init(locale: Locale, realm: Realm) {
    self.realm = realm
    self.locale = locale
    self.webService.delegate = self
  }
  
  func fetchAuctions() {
    self.webService.requestCurrentAuctionData(withRealm: .defiasBrotherhood, withLocale: .enGB)
  }
  
  func simplePrice(forRecipeComponents components: [RecipeComponent]) -> Price? {
    var totalCopper = 0
    for component in components {
      if let lowestPrice = self.lowestPrice(forItem: component.item) {
        totalCopper = totalCopper + lowestPrice.copperValue * component.quantity
      } else {
        return nil
      }
    }
    return Price(copperValue: totalCopper)
  }
  
  func lowestPrice(forItem item: Item) -> Price? {
    var filteredAuctions = [Auction]()
    if let auctions = self.auctions {
      for auction in auctions {
        if auction.item == item {
          filteredAuctions.append(auction)
        }
      }
    }
    filteredAuctions = filteredAuctions.sorted(by: { (firstAuction, secondAuction) -> Bool in
      return (Float(firstAuction.buyoutPrice.copperValue) / Float(firstAuction.quantity)) < (Float(secondAuction.buyoutPrice.copperValue) / Float(secondAuction.quantity))
    })
    if let cheapestAuction = filteredAuctions.first {
      return Price(copperValue: Int(round(Float(cheapestAuction.buyoutPrice.copperValue) / Float(cheapestAuction.quantity))))
    }
    return nil
  }
  
  // MARK: - WebRequestServiceDelegate
  func webRequestService(_ webService: WebRequestService, receivedAuctions auctions: [Auction]) {
    print("Auction House received auctions: \(auctions)")
    self.auctions = auctions
    self.delegate?.auctionHouse(self, receivedAuctions: auctions)
  }
}
