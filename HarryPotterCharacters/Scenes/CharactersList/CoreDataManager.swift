//
//  CoreDataManager.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 24.08.2021.
//

import CoreData
import UIKit

final class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "Characters")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()

    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveCharacter(name: String) {
        do {
            let character = NSEntityDescription.insertNewObject(forEntityName: "Characters", into: moc)
            character.setValue(name, forKey: "name")
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    func fetchCharacters() -> [Characters] {
        let fetchRequest = NSFetchRequest<Characters>(entityName: "Characters")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let characters = try moc.fetch(fetchRequest)
            return characters
        } catch {
            print(error)
            return []
        }
        
    }
    
    func deleteCharacter(chosenName: String) {
        let fetchRequest = NSFetchRequest<Characters>(entityName: "Characters")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "name = %@",chosenName)
        do {
            let results = try moc.fetch(fetchRequest)
            for result in results {
                if let name = result.value(forKey: "name") as? String {
                    if name == chosenName {
                        moc.delete(result)
                    }
                    do {
                        try moc.save()
                    } catch {
                        print(error)
                    }
                    
                }
            }
        } catch {
            print(error)
        }
    }
}
