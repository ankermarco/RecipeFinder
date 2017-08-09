//
//  RecipesViewController.swift
//  RecipeFinder
//
//  Created by Ke Ma on 09/08/2017.
//  Copyright © 2017 ke.ma. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController
{
  @IBOutlet weak var searchBar: UISearchBar!
  
  @IBOutlet weak var tableView: UITableView!
  
  var recipesInteractor : RecipeInteractor!
  var recipes = [Recipe]()
  
  fileprivate let CellId = "CellID"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    tableView.dataSource = self

    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension RecipesViewController: UISearchBarDelegate{
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let requestUrl = "http://www.recipepuppy.com/api/?q=\(searchText)"
    guard searchText.characters.count > 0 else {
      recipes.removeAll()
      self.tableView.reloadData()
      return
    }

    if recipesInteractor == nil {
      recipesInteractor = RecipeInteractor(requestUrl)
    } else {
      recipesInteractor.requestUrl = requestUrl
    }
    recipes = recipesInteractor.fetchRecipes()
    self.tableView.reloadData()
  }
}

extension RecipesViewController: UITableViewDataSource
{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath)
    cell.textLabel?.text = recipes[indexPath.row].name
    
    return cell
  }
}
