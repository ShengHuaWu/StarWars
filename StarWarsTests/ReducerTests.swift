//
//  ReducerTests.swift
//  StarWars
//
//  Created by ShengHua Wu on 14/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import XCTest
import ReSwift
@testable import StarWars

// MARK: - Reducer Tests
class ReducerTests: XCTestCase {
    // MARK: Enabled Tests
    func testFilmsReducerWithSetFilmsAction() {
        let action = SetFilmsAction(films: [])
        
        let state = filmsReducer(action: action, state: nil)
        
        XCTAssert(state == .finished([]))
    }
    
    func testFilmsReducerWithLoadingFilmsAction() {
        let action = LoadingFilmsAction()
        
        let state = filmsReducer(action: action, state: nil)
        
        XCTAssert(state == .loading)
    }
}

// MARK: - Films State Extension
extension FilmsState: Equatable {
    public static func ==(lhs: FilmsState, rhs: FilmsState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.finished, .finished): return true
        default: return false
        }
    }
}
