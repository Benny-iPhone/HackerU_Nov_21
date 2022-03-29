//
//  EverythingViewController.swift
//  NewsAPI
//
//  Created by Benny Davidovitz on 29/03/2022.
//

import UIKit
import EmptyDataSet_Swift

class EverythingViewController: ArticlesViewController, UISearchBarDelegate {
    
    weak var searchBar: UISearchBar!
    
    override var loadOnStart: Bool {
        false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupEmptyDataSet()
        tableView.reloadData()
    }
    
    private func setupEmptyDataSet() {
        tableView.emptyDataSetView { view in
            view.titleLabelString(NSAttributedString(string: "No Data to show"))
                .image(UIImage(named: "icons8-window_search")!)
                .buttonTitle(NSAttributedString(string: "Search"), for: .normal)
                .dataSetBackgroundColor(UIColor.systemBlue.withAlphaComponent(0.6))
                .shouldFadeIn(true)
                .isTouchAllowed(true)
                .didTapDataButton {
                    self.searchBar.becomeFirstResponder()
                    // Do something
                }
        }
    }
    
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search everything"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        self.searchBar = searchBar
    }
    
    override func sendNetworkingRequest() {
        guard let text = searchBar.text else {
            //load empty result
            self.handle(result: .success([]))
            return
        }
        
        //[weak self] - refere itself weakly, to avoid retain cycle
        Networking.shared.getEverything(with: text) { [weak self] result in
            guard let self = self else { return }
            self.handle(result: result)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //reload with current search term
        startOver()
        searchBar.resignFirstResponder()
    }

}
