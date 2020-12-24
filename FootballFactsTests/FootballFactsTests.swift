//
//  FootballFactsTests.swift
//  FootballFactsTests
//
//  Created by Akanksha Harsh Saxena on 23/12/20.
//

import XCTest
@testable import FootballFacts
import CoreData
class FootballFactsTests: XCTestCase {
    
    var competitionsArray : Competitions!
    var standingsArray: Standings!
    var coreDataManager: CoreDataManager!
    var privateContext : CoreDataPrivateContext!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManager.sharedInstance
        privateContext = CoreDataPrivateContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = coreDataManager.managedObjectContext

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_initCoreDataManager(){
        
        let instance = CoreDataManager.sharedInstance
        
        /*Asserts that an expression is not nil.
         Generates a failure when expression == nil.*/
        XCTAssertNotNil( instance )
        
        
    }
    
    func test_coreDataContextInitialization() {
        let coreDataStack = CoreDataManager.sharedInstance.managedObjectContext
        
        /*Asserts that an expression is not nil.
         Generates a failure when expression == nil.*/
        XCTAssertNotNil( coreDataStack )
    }
    
    func test_privateContext(){
        let childContext = CoreDataPrivateContext(concurrencyType: .privateQueueConcurrencyType)
        XCTAssertNotNil(childContext)
    }
    
    func test_saveCompetitons() {
        let bundle = Bundle(for: FootballFactsTests.self)
        var jsonResponse = [String:Any]()
        let filePath = bundle.url(forResource: "competitions", withExtension: "json")
        do{
            let data = try Data(contentsOf: filePath!)
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
        }catch{
            print("Error")
        }
        XCTAssertNotNil( filePath )
        XCTAssertNotNil(jsonResponse)
        XCTAssertNotNil(privateContext)
        privateContext.perform { [self] in
            self.privateContext.saveCompetitionsData(jsonResponse: jsonResponse)
            self.privateContext.saveContext()
            self.coreDataManager.managedObjectContext.performAndWait {
                self.coreDataManager.saveContext()
            }

        }

    }
    
    func test_fetchCompetitions(){
        let a = coreDataManager.fetchComeptitionsFromCoreData()
        XCTAssertNotNil(a, "Data being fetched correctly")
        // XCTAssertNotNil(report.dateReported, "dateReported should not be nil")
        
    }
    
    
    
    func test_saveStandings() {
        let bundle = Bundle(for: FootballFactsTests.self)
        var jsonResponse = [String:Any]()
        let filePath = bundle.url(forResource: "standings", withExtension: "json")
        do{
            let data = try Data(contentsOf: filePath!)
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
        }catch{
            print("Error")
        }
        XCTAssertNotNil( filePath )
        XCTAssertNotNil(jsonResponse)
        XCTAssertNotNil(privateContext)
        privateContext.perform { [self] in
            self.privateContext.deleteStandings(leagueId: 2021)
            self.privateContext.saveLeagueData(jsonResponse: jsonResponse, leagueId: 2021)
            self.privateContext.saveContext()
            self.coreDataManager.managedObjectContext.performAndWait {
                self.coreDataManager.saveContext()
            }
        }
    }
    
    func test_fetchStandings(){
        let a = coreDataManager.fetchStandingsFromCoreData(leagueId: 2021)
        XCTAssertNotNil(a, "Data being fetched correctly")
        // XCTAssertNotNil(report.dateReported, "dateReported should not be nil")
        
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
