//
//  Database.swift
//  PlacesApp
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import CoreData
import CoreLocation
import UIKit

//This class manage the database connection and operations
//Will be accesiable as shared instance
class Database {
    
    static let database = Database()
    
    let fileController = FileController()
    
    func createPlace(with name: String, image: UIImage?, coordinate: CLLocationCoordinate2D) {
        let context = self.persistentContainer.viewContext
        let place = Place(context: context)
        place.name = name
        if let image = image {
            //1. save image to disk
            let filename = fileController.save(image: image)
            //2. fulfill imagename
            place.imageName = filename
        }
        place.latitude = coordinate.latitude
        place.longitude = coordinate.longitude
        place.createdAt = Date()
        
        //save
        saveContext()
    }
    
    //NSFetchedResultsController - an object that retain the fetched objects, and, notifies about any update in the query scope
    func readPlaces() -> NSFetchedResultsController<Place> {
        //it is important to specify the type NSFetchRequest<Place> to avoid compiler errors
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        //request.predicate = NSPredicate(format: "name contains %@", filterName)
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        let context = self.persistentContainer.viewContext
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //execute fetch
        do {
            try controller.performFetch()
        } catch {
            print(error)
        }
        
        return controller
    }
    
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PlacesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
