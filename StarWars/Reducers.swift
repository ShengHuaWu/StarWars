//
//  Reducers.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(filmsState: filmsReducer(action: action, state: state?.filmsState))
}

func filmsReducer(action: Action, state: FilmsState?) -> FilmsState {
    switch action {
    case let action as SetFilmsAction:
        return .finished(action.films)
    case _ as LoadingFilmsAction:
        return .loading
    default:
        return state ?? .finished([])
    }
}
