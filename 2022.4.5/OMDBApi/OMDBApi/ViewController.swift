//
//  ViewController.swift
//  OMDBApi
//
//  Created by Benny Davidovitz on 05/04/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var performSearchWorkItem: DispatchWorkItem?
    private var collectionArray: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        searchBar.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    private func drainCollectionView() {
        collectionArray = []
        collectionView.reloadData()
    }
    
    private func performSearch() {
        guard let text = searchBar.text, !text.isEmpty else {
            drainCollectionView()
            return
        }
        
        Networking.shared.search(term: text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let arr):
                self.collectionArray = arr
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchResultCell

        let item = collectionArray[indexPath.item]
        cell.populate(with: item)
        
//        let label = cell.viewWithTag(1) as? UILabel
//        label?.text = "\(indexPath.item)"
//        cell.contentView.backgroundColor = (indexPath.item % 2 == 0) ? .lightGray : .systemBlue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // throttle - wait for user to hold his typing
        
        //cancel old task
        self.performSearchWorkItem?.cancel()
        
        //issue a new task for 0.5 seconds from now
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.performSearch()
            self.performSearchWorkItem = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
        self.performSearchWorkItem = workItem
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        drainCollectionView()
        searchBar.resignFirstResponder()
    }
    
}
