//
//  _0180928_JoshSingh_NYCSchoolsTests.swift
//  20180928-JoshSingh-NYCSchoolsTests
//
//  Created by Yash Singh on 9/28/18.
//  Copyright © 2018 Yash Singh. All rights reserved.
//

import XCTest
@testable import _0180928_JoshSingh_NYCSchools

class _0180928_JoshSingh_NYCSchoolsTests: XCTestCase {
    
    let testVM = SchoolViewModel()
    let testSchoolListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SchoolListViewController.self)) as! SchoolListViewController
    let testSATVC = SATViewController()
    
    let timeout = 15.0
    let defaultSearchText = "T"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetSchoolData(){
        let expected = expectation(description: "Loaded schools")
        
        testVM.getSchoolData { (testSchoolArray) in
            XCTAssertNotNil(testSchoolArray)
            XCTAssertEqual(testSchoolArray.count, 440)
            
            expected.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testGetSATData(){
        let expected = expectation(description: "Loaded SAT Data")
        
        testVM.getSATData { (testSATArray) in
            XCTAssertNotNil(testSATArray)
            XCTAssertEqual(testSATArray.count, 478)
            
            expected.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testSearchResults(){
        let expected = expectation(description: "Search Results Test")
        
        let SchoolModelObj1 = SchoolModel()
        SchoolModelObj1.school_name = "Teachers Preparatory High School"
        
        let SchoolModelObj2 = SchoolModel()
        SchoolModelObj2.school_name = "The College Academy"
        testVM.schoolDataArray = [SchoolModelObj1, SchoolModelObj2]
        
        testVM.searchResults(searchText: defaultSearchText)
        XCTAssertNotNil(testVM.searchedSchoolDataArray)
       
        XCTAssertTrue(testVM.searchedSchoolDataArray.count > 0)
        
        expected.fulfill()
        waitForExpectations(timeout: timeout, handler: nil)
    }

 
}
