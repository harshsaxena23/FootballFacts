//
//  CoreDataStack.swift
//  FootballFacts
//
//  Created by Harsh Saxena on 21/12/20.
//

import Foundation
import CoreData

open class CoreDataManager{
    
    
    static let sharedInstance = CoreDataManager()
    lazy var applicationsDirectoryUrl : URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: Constants.dataModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let urlPath = self.applicationsDirectoryUrl.appendingPathComponent("\(Constants.dataModelName).sqlite")
        let mOptions = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: urlPath, options: mOptions)
        }catch {
            print("There was an issue with initializing the store coordinator")
        }
        return coordinator
        
        
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return managedContext
    }()
    
    func saveContext(){
        if managedObjectContext.hasChanges {
            do {
                try  managedObjectContext.save()
                
            }catch {
                let error = error as NSError
                print(error.userInfo)
                abort()
            }
        }
    }
    
    func fetchComeptitionsFromCoreData() -> [Competitions]{
        let wantedItemIDs : [Int16] = [2021, 2002, 2014, 2015, 2019]
        let fetchRequest : NSFetchRequest<Competitions> = Competitions.fetchRequest()
        fetchRequest.includesSubentities = true
        let orderSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [orderSort]
        let inclusivePredicate = NSPredicate(format: "id IN %@", wantedItemIDs)
        fetchRequest.predicate = inclusivePredicate

        do{
            let results = try managedObjectContext.fetch(fetchRequest)
            return results
        }catch{
            print("Unable to fetch")
        }
        
        return []
    }
    
    func fetchStandingsFromCoreData(leagueId: Int16) -> [Standings] {
        let fetchRequest : NSFetchRequest<Standings> = Standings.fetchRequest()
        fetchRequest.includesSubentities = true
        fetchRequest.predicate = NSPredicate(format: "league_id==\(leagueId)")
        let orderSort = NSSortDescriptor(key: "position", ascending: true)
        fetchRequest.sortDescriptors = [orderSort]
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            return results
        } catch {
            //print ("There was an error")
            print("Unable to fetch")

        }
        return []
    }
    
}
