//
//  Item.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 16/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import Foundation

typealias RecipeComponent = (item: Item, quantity: Int)

enum Item: Int, Codable {

  // Herbs
  case starMoss = 152506
  case seaStalk = 152511
  case sirensPollen = 152509
  case wintersKiss = 152508
  case akundasBite = 152507
  case riverbud = 152505
  case anchorWeed = 152510
  
  // Fish
  case sandShifter = 152543
  
  
  // Craftables
  
  // Potions - MP/HP
  case coastalHealingPotion = 152494
  case coastalManaPotion = 152495
  case coastalRejuvenationPotion = 163082
  
  // Potions - Utility
  case lightfootPotion = 152497
  case seaMistPotion = 152550
  case potionOfConcealment = 152503
  case demitrisDraughtOfDeception = 152496
  
  // Potions - Pre-Pull
  // Type 1
  case steelskinPotion = 152557
  case potionOfRisingDeath = 152559
  case potionOfBurstingBlood = 152560
  case potionOfReplenishment = 152561
  // Type 2
  case battlePotionOfAgility = 163223
  case battlePotionOfIntellect = 163222
  case battlePotionOfStrength = 163224
  case battlePotionOfStamina = 163225
  
  // Flasks
  case flaskOfTheCurrents = 152638
  case flaskOfEndlessFathoms = 152639
  case flaskOfTheUndertow = 152641
  case flaskOfTheVastHorizon = 152640
  
  var recipe: [RecipeComponent]? {
    switch self {
    case .flaskOfTheCurrents:
      return [
        (item: .akundasBite, quantity: 10),
        (item: .seaStalk, quantity: 15),
        (item: .anchorWeed, quantity: 5)
      ]
    case .flaskOfEndlessFathoms:
      return [
        (item: .wintersKiss, quantity: 10),
        (item: .riverbud, quantity: 15),
        (item: .anchorWeed, quantity: 5)
      ]
    case .flaskOfTheUndertow:
      return [
        (item: .akundasBite, quantity: 10),
        (item: .sirensPollen, quantity: 15),
        (item: .anchorWeed, quantity: 5)
      ]
    case .flaskOfTheVastHorizon:
      return [
        (item: .wintersKiss, quantity: 10),
        (item: .starMoss, quantity: 15),
        (item: .anchorWeed, quantity: 5)
      ]
    case .battlePotionOfAgility:
      return [
        (item: .sirensPollen, quantity: 10),
        (item: .riverbud, quantity: 8)
      ]
    case .battlePotionOfIntellect:
      return [
        (item: .sirensPollen, quantity: 10),
        (item: .riverbud, quantity: 8)
      ]
    case .battlePotionOfStrength:
      return [
        (item: .seaStalk, quantity: 10),
        (item: .starMoss, quantity: 8)
      ]
    case .battlePotionOfStamina:
      return [
        (item: .seaStalk, quantity: 10),
        (item: .starMoss, quantity: 8)
      ]
    case .steelskinPotion:
      return [
        (item: .seaStalk, quantity: 10),
        (item: .riverbud, quantity: 8)
      ]
    case .potionOfRisingDeath:
      return [
        (item: .seaStalk, quantity: 10),
        (item: .starMoss, quantity: 8)
      ]
    case .potionOfBurstingBlood:
      return [
        (item: .sirensPollen, quantity: 10),
        (item: .riverbud, quantity: 8)
      ]
    case .potionOfReplenishment:
      return [
        (item: .sirensPollen, quantity: 10),
        (item: .starMoss, quantity: 8)
      ]
    case .lightfootPotion:
      return [
        (item: .starMoss, quantity: 10)
      ]
    case .potionOfConcealment:
      return [
        (item: .sirensPollen, quantity: 10)
      ]
    case .seaMistPotion:
      return [
        (item: .seaStalk, quantity: 10)
      ]
    case .demitrisDraughtOfDeception:
      return [
        (item: .sandShifter, quantity: 5),
        (item: .seaStalk, quantity: 5)
      ]
    default:
      return nil
    }
  }
}
