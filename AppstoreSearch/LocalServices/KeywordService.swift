//
//  KeywordService.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

import CoreData

final class KeywordService: KeywordServiceProtocol {
    static let shared = KeywordService(coreDataStack: CoreDataStack())
    var managedObjContext: NSManagedObjectContext
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.managedObjContext = coreDataStack.mainContext
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - CREATE Services
    func createKeyword(title: String, timeStamp: Date) -> Keyword? {
        if getKeywordByMatchingTitle(title: title) != nil {
            return nil
        }
        
        let keyword = Keyword(context: managedObjContext)
        keyword.title = title
        keyword.timeStamp = timeStamp
        keyword.score = 1
        
        managedObjContext.perform {
            self.coreDataStack.saveContext(self.managedObjContext)
        }
        return keyword
    }
    
    // MARK: - GET Services
    func getRecentKeywors() -> [Keyword]? {
        let fetchRequest: NSFetchRequest<Keyword> = Keyword.fetchRequest()
        let timeSort = NSSortDescriptor(key: #keyPath(Keyword.timeStamp), ascending: false)
        let scoreSort = NSSortDescriptor(key: #keyPath(Keyword.score), ascending: false)
        let titleSort = NSSortDescriptor(key: #keyPath(Keyword.title), ascending: true)
        
        fetchRequest.sortDescriptors = [timeSort, scoreSort, titleSort]
        
        let keywords: [Keyword]?
        do {
            keywords = try managedObjContext.fetch(fetchRequest)
        } catch {
            return nil
        }
        return keywords
    }
    
    func getKeywordByMatchingTitle(title: String) -> Keyword? {
        let fetchRequest: NSFetchRequest<Keyword> = Keyword.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(Keyword.title), title])
        let keywords: [Keyword]?
        do {
            keywords = try managedObjContext.fetch(fetchRequest)
        } catch {
            return nil
        }
        return keywords?.first
    }
    
    func getKeywordsByContainTitle(title: String) -> [Keyword]? {
        let fetchRequest: NSFetchRequest<Keyword> = Keyword.fetchRequest()
        let scoreSort = NSSortDescriptor(key: #keyPath(Keyword.score), ascending: false)
        let titleSort = NSSortDescriptor(key: #keyPath(Keyword.title), ascending: true)
        let timeSort = NSSortDescriptor(key: #keyPath(Keyword.timeStamp), ascending: true)
        
        fetchRequest.sortDescriptors = [scoreSort, titleSort, timeSort]
        fetchRequest.predicate = NSPredicate(format: "title contains[c] %@", title)
        
        let keywords: [Keyword]?
        do {
            keywords = try managedObjContext.fetch(fetchRequest)
        } catch {
            return nil
        }
        return keywords
    }
    
    // MARK: - UPDATE Services
    func updateKeywordScoreByMatchingTitle(title: String) -> Keyword? {
        guard let keyword = getKeywordByMatchingTitle(title: title) else {
            return nil
        }
        keyword.score += 1
        managedObjContext.perform {
            self.coreDataStack.saveContext(self.managedObjContext)
        }
        return keyword
    }
}
