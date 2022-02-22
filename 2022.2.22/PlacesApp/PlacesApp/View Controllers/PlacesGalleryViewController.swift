//
//  PlacesGalleryViewController.swift
//  PlacesApp
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import UIKit
import CoreData

class PlacesGalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var controller: NSFetchedResultsController<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller = Database.database.readPlaces()
        //register for database changes updates
        controller.delegate = self

        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension PlacesGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //how many items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //currently we are using only 1 section, so section value is 0
        return controller.sections?[section].numberOfObjects ?? 0
    }
    
    //ui element to display
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlaceCell
        
        let place = controller.object(at: indexPath)
        cell.populate(with: place)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
//        let w = self.view.bounds.width / 3 - 8
//        return CGSize(width: w, height: w)
    }
    
    
    
}

extension PlacesGalleryViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        //If we will find that multiple updates causing crash, then we will have to queue the udpates
        //https://stackoverflow.com/questions/20554137/nsfetchedresultscontollerdelegate-for-collectionview/20554673#20554673
        //collectionView.performBatchUpdates {}
        
        switch type {
        case .insert:
            collectionView.insertItems(at: [newIndexPath!])
        case .delete:
            break
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }

    }
}
