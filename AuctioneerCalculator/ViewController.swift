//
//  ViewController.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 16/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AuctionHouseDelegate {

  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var activityParentView: UIView!
  @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
  
  private var auctionHouse: AuctionHouse?
  
  override func viewDidLoad() {
    super.viewDidLoad()    
    self.auctionHouse = AuctionHouse(locale: .enGB, realm: .defiasBrotherhood)
    auctionHouse?.delegate = self
    auctionHouse?.fetchAuctions()
    activityParentView.alpha = 1
    loadingActivityView.alpha = 1
    loadingActivityView.startAnimating()
  }
  
  @IBAction func executeAction() {
    let requestedItem = Item.flaskOfTheVastHorizon
    if let recipe = requestedItem.recipe {
      if let estimatedPrice = self.auctionHouse?.simplePrice(forRecipeComponents: recipe) {
        print("Estimated recipe price for \(requestedItem): \(estimatedPrice.prettyPrice)")
      }
      if let price = self.auctionHouse?.lowestPrice(forItem: requestedItem) {
        print("AH price for \(requestedItem): \(price.prettyPrice)")
      }
      if let anchorWeedPrice = self.auctionHouse?.lowestPrice(forItem: .anchorWeed) {
        print("Price for Anchor Weed: \(anchorWeedPrice.prettyPrice)")
      }
    }
  }

  // MARK: - AuctionHouseDelegate
  func auctionHouse(_ auctionHouse: AuctionHouse, receivedAuctions auctions: [Auction]) {
    print("Auction house '\(auctionHouse.realm.rawValue)' received \(auctions)")
    UIView.animate(withDuration: 0.3) {
      self.button.alpha = 1
      self.button.backgroundColor = .cyan
      self.loadingActivityView.stopAnimating()
      self.loadingActivityView.alpha = 0
      self.activityParentView.alpha = 0
    }
  }
}

class APIConfig {
  
  static let key = "YOUR_API_KEY_HERE"
}

enum Locale: String {
  
  case enGB = "en_GB"
  case enUS = "en_US"
  case deDE = "de_DE"
  case esES = "es_ES"
  case frFR = "fr_FR"
  case itIT = "it_IT"
  case plPL = "pl_PL"
  case ptPT = "pt_PT"
  case ruRU = "ru_RU"
  
  static let allLocales = [enGB, enUS, deDE, esES, frFR, itIT, plPL, ptPT, ruRU]

}

enum Realm: String {
  
  case defiasBrotherhood = "defias-brotherhood"
  case sporegarr = "sporeggar"
  case ravenholdt = "ravenholdt"
  case theVentureCo = "the-venture-co"
  case scarshieldLegion = "scarshield-legion"
  
  static let allRealms = [defiasBrotherhood, sporegarr, ravenholdt, ravenholdt, scarshieldLegion]
  
  var displayName: String {
    switch self {
    case .defiasBrotherhood:
      return "Defias Brotherhood"
    case .sporegarr:
      return "Sporeggar"
    case .ravenholdt:
      return "Ravenholdt"
    case .theVentureCo:
      return "The Venture Co"
    case .scarshieldLegion:
      return "Scarshield Legion"
    }
  }
  
  var urlEncodedName: String {
    switch self {
    case .defiasBrotherhood:
      return "Defias%20Brotherhood"
    case .sporegarr:
      return "Sporeggar"
    case .ravenholdt:
      return "Ravenholdt"
    case .theVentureCo:
      return "The%20Venture%20Co"
    case .scarshieldLegion:
      return "Scarshield%20Legion"
    }  
  }
  
//  var realms: [Realm] {
//    switch self {
//    case .eu:
//      return [Realm.realm1, Realm.realm2]
//    case .us:
//      return []
//    }
//  }
}

