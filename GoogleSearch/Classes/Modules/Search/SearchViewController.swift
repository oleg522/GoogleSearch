//
//  SearchViewController.swift
//  GoogleSearch
//
//  Created by Oleg Bakatin on 16.02.2020.
//  Copyright © 2020 Oleg Bakatin. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var presenter = SearchPresenter()
    
    let searchController = UISearchController(searchResultsController: nil)
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupPresenter()
        
    }
}

// MARK: - Private and setup function
extension SearchViewController {
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
    }
}

// MARK: - Input View Handler (Or Presenter Output)
extension SearchViewController {
    func setupPresenter() {
        
        presenter.showMessage = { [weak self] text in
            guard let self = self else { return }
            self.showAlert(message: text)
        }
        
        presenter.showBooks = { [weak self] books in
            guard let self = self else { return }
            self.books = books
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewController functions
extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Cells.book)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: Cells.book)
        }
        
        cell?.textLabel?.text = books[indexPath.row].title
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: Segues.showDetails, sender: book)
    }
}

// MARK: - Navigation
extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showDetails {
            guard let vc = segue.destination as? DetailsViewController, let book = sender as? Book else { return }
            vc.book = book
        }
    }
}

// MARK: - SearchBar functions
extension SearchViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchController.searchBar.text else { return }
        presenter.search(text: text)
        if text.isEmpty {
            books = []
            tableView.reloadData()
        }
    }
}
