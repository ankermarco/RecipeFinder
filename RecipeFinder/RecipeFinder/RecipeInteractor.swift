//
//  RecipeInteractor.swift
//  RecipeFinder
//
//  Created by Ke Ma on 09/08/2017.
//  Copyright © 2017 ke.ma. All rights reserved.
//

import Alamofire
import Alamofire_Synchronous
import SwiftyJSON


class RecipeInteractor {
  
  var requestUrl : String
  
  init(_ url: String) {
    self.requestUrl = url
  }
  
  private func getFromUrl() -> JSON {
    let response = Alamofire.request(self.requestUrl).responseJSON()
    
    if let json = response.result.value {
      return JSON(json)
    }
    return JSON.null
  }

  func fetchRecipes() -> [Recipe] {
    var recipes = [Recipe]()
    let value = self.getFromUrl()

    if value != JSON.null {
      if let items = value.dictionary?["results"]?.array {
        for item in items {
          if let title = item.dictionary?["title"]?.string {
            let recipe = Recipe(title)
            recipes.append(recipe)
          }
        }
      }
    }
    
    return recipes
  }
}

