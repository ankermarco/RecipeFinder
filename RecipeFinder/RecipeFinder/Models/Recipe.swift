//
//  Recipe.swift
//  RecipeFinder
//
//  Created by Ke Ma on 09/08/2017.
//  Copyright © 2017 ke.ma. All rights reserved.
//

struct Recipe
{
  var name : String
  
  init(_ name: String?) {
    self.name = name ?? ""
  }
}
