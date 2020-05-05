//
//  PersistentDataManager.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 5/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  CoreData
final class PersistentDataManager {
    private init(){}
    static let shared = PersistentDataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "EntainmentWorld")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    lazy var context = persistentContainer.viewContext
    
    
    
    
    // MARK: - Core Data Saving support

    func Save () {
       // let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved Succefully")
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func Fetech <T: NSManagedObject> (_ objectType: T.Type) ->[T] {
        let entityName =  String(describing: objectType)
        let fetechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do{
            let fetchObject = try context.fetch(fetechRequest) as? [T]
                    return fetchObject ?? [T]()
        }catch{
            print(error)
            return [T]()
        }
    }
    
    
    func deleteItem(_ object: NSManagedObject){
        context.delete(object)
        Save()
    }
}
 
 
