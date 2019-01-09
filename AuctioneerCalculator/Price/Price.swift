//
//  Price.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 20/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import Foundation

struct Price {
  
  let copperValue: Int
  var prettyPrice: (gold: Int, silver: Int, copper: Int) {
    var remainderCopper = copperValue
    let goldCopperValue = 10000
    let silverCopperValue = 100
    
    let gold = remainderCopper / goldCopperValue
    remainderCopper = remainderCopper - gold * goldCopperValue
    
    let silver = remainderCopper / silverCopperValue
    remainderCopper = remainderCopper - silver * silverCopperValue
    
    return (gold: gold, silver: silver, copper: remainderCopper)
  }
  
  init?(copperValue: Int) {
    if copperValue != 0 {
      self.copperValue = copperValue
    } else {
      return nil
    }
  }
}
