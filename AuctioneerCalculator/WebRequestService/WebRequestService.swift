//
//  WebRequestService.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 16/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import Foundation
import Alamofire

protocol WebRequestServiceDelegate {
  func webRequestService(_ webService: WebRequestService, receivedAuctions auctions: [Auction])
}

class WebRequestService {

  var delegate: WebRequestServiceDelegate?
  
  func requestCurrentAuctionData(withRealm realm: Realm, withLocale locale: Locale, andKey key: String = APIConfig.key) {
    // Realm: Defias%20Brotherhood
    // Locale: en_GB
    
    let url = "https://eu.api.battle.net/wow/auction/data/\(realm.urlEncodedName)?locale=\(locale.rawValue)&apikey=\(key)"
      print("Url: \(url)")
      print("Request url: \(url)")
    Alamofire.request(url).responseJSON { (response) in
      //print("response: \(response.result.value)")
      if let data = response.result.value as? [String: Any] {
        if let fileDataArray = data["files"] as? [[String: Any]] {
          // Getting the JSON file in the "files" array
          // print("File array: \(fileDataArray))")
          for fileData in fileDataArray {
            if let fileDataUrl = fileData["url"] as? String {
              // print("File url: \(fileDataUrl)")
              self.requestAuctions(fromUrl: fileDataUrl)
            }
          }
        }
      }
    }
  }
  
  private func requestAuctions(fromUrl url: String) {
    print("Starting request for \(url)")
    Alamofire.request(url).responseJSON { (response) in
      // print("Response: \(response)")
      if let data = response.result.value as? [String: Any], let auctionDataArray = data["auctions"] as? [[String: Any]] {
        // print("Auction Data Array: \(auctionDataArray)")
        let auctions = AuctionBuilder().buildAuctions(withArray: auctionDataArray)
        self.delegate?.webRequestService(self, receivedAuctions: auctions)
        print("Auctions: \(auctions)")
      } else {
        print("Error building Auctions")
      }
    }
  }
}
