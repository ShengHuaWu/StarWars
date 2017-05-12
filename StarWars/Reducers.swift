//
//  Reducers.swift
//  StarWars
//
//  Created by ShengHua Wu on 12/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(filmsState: filmsRedcuer(action: action, state: state?.filmsState))
}


//struct FilmReducer
func filmsRedcuer(action: Action, state: FilmsState?) -> FilmsState {
    switch action {
    case let action as FetchFilmAction:
        let webService = WebService()
        webService.load(resource: action.resource, completion: { (result) in
            switch result {
            case let .success(films):
                store.dispatch(AssignFilmAction(films: films))
            case let .failure(error):
                print(error)
            }
        })
    case let action as AssignFilmAction:
        return FilmsState(films: action.films)
    default:
        break
    }
    
    return state ?? FilmsState(films: [])
}
