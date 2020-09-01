//
//  KeywordServiceTests.swift
//  AppstoreSearchTests
//
//  Created by Eido Goya on 2020/08/28.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import AppstoreSearch
import XCTest
import CoreData

class KeywordServiceTests: XCTestCase {
    
    var testCoreDataStack: CoreDataStack!
    var mockKeywordService: MockKeywordService!

    override func setUpWithError() throws {
        testCoreDataStack = TestCoreDataStack()
        mockKeywordService = MockKeywordService(coreDataStack: testCoreDataStack)
    }

    override func tearDownWithError() throws {
        mockKeywordService = nil
        testCoreDataStack = nil
    }
    
    func testRootContext_afterCreateKeyword_isSaved() {
        // given
        let derivedContext = testCoreDataStack.newDerivedContext()
        
        expectation(
            forNotification: .NSManagedObjectContextDidSave,
            object: testCoreDataStack.mainContext
        ) { (notification) -> Bool in
            return true
        }
        
        // when
        derivedContext.perform {
            let keyword = self.mockKeywordService.createKeyword(title: "카카오", timeStamp: Date())
            XCTAssertNotNil(keyword)
        }
        
        // than
        waitForExpectations(timeout: 2.0) { (error) in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testKeyword_getRecentKeywors_result() {
        // given
        _ = mockKeywordService.createKeyword(title: "카카오뱅", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅ㅋ", timeStamp: Date())
        
        _ = mockKeywordService.createKeyword(title: "카카오뱅크", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크", timeStamp: Date())
        
        _ = mockKeywordService.createKeyword(title: "카카오뱅쿠", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅킹", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크 - 같지만 다른 은행", timeStamp: Date())
        
        // when
        let keywords = mockKeywordService.getRecentKeywors()
        
        // than
        XCTAssertEqual(keywords?.count, 6)
        XCTAssertTrue(keywords!.first!.title == "카카오뱅크 - 같지만 다른 은행")
    }
    
    func testKeyword_getKeywordsByTitle_resultCount() {
        // given
        _ = mockKeywordService.createKeyword(title: "카카오뱅", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅ㅋ", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅쿠", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅킹", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크 - 같지만 다른 은행", timeStamp: Date())
        
        // when
        let keywords = mockKeywordService.getKeywordsByContainTitle(title: "카카오뱅")
        
        // than
        XCTAssertEqual(keywords?.count, 6)
    }
    
    func testKeyword_getKeywordsByTitle_resultOrder() {
        // given
        let title = "카카오뱅"
        _ = mockKeywordService.createKeyword(title: title, timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅ㅋ", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅쿠", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅킹", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크 - 같지만 다른 은행", timeStamp: Date())
        guard let _ = mockKeywordService.updateKeywordScoreAndDateByMatchingTitle(title: title) else {
            fatalError()
        }
        
        // when
        let keywords = mockKeywordService.getKeywordsByContainTitle(title: title)
        
        // than
        XCTAssertEqual(keywords?.first?.title, title)
    }
    
    func testKeyword_updateKeywordByTitle_resultValue() {
        // given
        let title = "카카오뱅"
        _ = mockKeywordService.createKeyword(title: title, timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅ㅋ", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅쿠", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅킹", timeStamp: Date())
        _ = mockKeywordService.createKeyword(title: "카카오뱅크 - 같지만 다른 은행", timeStamp: Date())
        
        // when
        guard let keyword = mockKeywordService.updateKeywordScoreAndDateByMatchingTitle(title: title) else {
            fatalError()
        }
        
        // than
        XCTAssertGreaterThan(keyword.score, 1)
    }
}

class MockKeywordService: KeywordServiceProtocol {
    
    var managedObjContext: NSManagedObjectContext
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.managedObjContext = coreDataStack.mainContext
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - CREATE Services
    func createKeyword(title: String, timeStamp: Date) -> Keyword? {
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
    func updateKeywordScoreAndDateByMatchingTitle(title: String) -> Keyword? {
        guard let keyword = getKeywordByMatchingTitle(title: title) else {
            return nil
        }
        keyword.timeStamp = Date()
        keyword.score += 1
        managedObjContext.perform {
            self.coreDataStack.saveContext(self.managedObjContext)
        }
        return keyword
    }
}
