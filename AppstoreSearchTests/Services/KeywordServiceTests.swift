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

}

class MockKeywordService: KeywordServiceProtocol {
    
    var managedObjContext: NSManagedObjectContext
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.managedObjContext = coreDataStack.mainContext
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - CREATE Services
    func createKeyword(title: String, timeStamp: Date) -> Keyword {
        let keyword = Keyword(context: managedObjContext)
        keyword.title = title
        keyword.timeStamp = timeStamp
        keyword.score = 1
        
        managedObjContext.perform {
            self.coreDataStack.saveContext(self.managedObjContext)
        }
        return keyword
    }
}
