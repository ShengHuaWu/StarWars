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
    private var store: MockStore!
    
    // MARK: Override Methods
    override func setUp() {
        super.setUp()
        
        store = MockStore(reducer: appReducer, state: nil)
    }
    
    override func tearDown() {
        store = nil
        
        super.tearDown()
    }
    
    // MARK: Enabled Tests
    func testFetchFilmActionProvider() {
        let fetchFilmExpectation = expectation(description: "Fetch Film Action Provider")
        
        let state = AppState(filmsState: .loading)
        store.expectation = fetchFilmExpectation
        store.verify = { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.store.verify()
        }
        
        let action = fetchFilms(state: state, store: store)
        XCTAssert(action is LoadingFilmsAction)
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

// MARK: - Mock Store
final class MockStore: Store<AppState> {
    var expectation: XCTestExpectation?
    var verify: (() -> ())?
    private var dispatchCallCount = 0
    private var expectedAction: Action?
    
    override func dispatch(_ action: Action) {
        switch action {
        case _ as ReSwiftInit:
            break
        default:
            dispatchCallCount += 1
            expectedAction = action
            
            verify?()
            
            expectation?.fulfill()
        }
    }
    
    func verify(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(dispatchCallCount, 1, "count", file: file, line: line)
        XCTAssert(expectedAction is SetFilmsAction, "action", file: file, line: line)
    }
}
