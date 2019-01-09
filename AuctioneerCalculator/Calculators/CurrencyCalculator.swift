//
//  CurrencyCalculator.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 16/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import Foundation

class CurrencyCalculator {
  func convert(withCopper copper: Int) -> Int {
    let silverPrice = copper / 100
    let goldPrice = silverPrice / 100
    return goldPrice
  }
  
}
