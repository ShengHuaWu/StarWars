//
//  ActionProviderTests.swift
//  StarWars
//
//  Created by ShengHua Wu on 14/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
import ReSwift
@testable import StarWars

// MARK: - Action Provider Tests
class ActionProviderTests: XCTestCase {
    // MARK: Properties
    private var webService: MockWebService!
    
    // MARK: Override Methods
    override func setUp() {
        super.setUp()
        
        webService = MockWebService()
    }
    
    override func tearDown() {
        webService = nil
        
        super.tearDown()
    }
    
    // MARK: Enabled Tests
    func testFetchFilmActionProvider() {
        let state = AppState(filmsState: .loading)
        
        webService.expectedAction = fetchFilms(with: webService)(state, mainStore)
        
        webService.verify()
    }
}

// MARK: - Mock Web Service
final class MockWebService: WebServiceProtocol {
    private var loadCallCount = 0
    private var loadResource: Resource<[Film]>!
    var expectedAction: Action!
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ()) {
        loadCallCount += 1
        loadResource = resource as Any as! Resource<[Film]>
    }
    
    func verify(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(loadCallCount, 1, "call count", file: file, line: line)
        XCTAssertEqual(loadResource.url, Film.all.url, "resource url", file: file, line: line)
        XCTAssert(expectedAction is LoadingFilmsAction)
    }
}

