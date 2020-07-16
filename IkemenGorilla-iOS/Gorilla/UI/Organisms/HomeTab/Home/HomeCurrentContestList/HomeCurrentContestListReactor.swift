//
//  HomeCurrentContestListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeCurrentContestListReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setContestListCellReactors([Contest])
        case setIsLoading(Bool)
    }
    
    struct State {
        var contestListCellReactors: [HomeCurrentContestListCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return Observable.concat(
                Observable.just(.setIsLoading(true)),
                loadCurrentContests().map(Mutation.setContestListCellReactors),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadCurrentContests() -> Observable<[Contest]> {
        provider.contestService.getContests(status: .current, page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setContestListCellReactors(let contests):
            state.contestListCellReactors = contests.map { HomeCurrentContestListCellReactor(contest: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
