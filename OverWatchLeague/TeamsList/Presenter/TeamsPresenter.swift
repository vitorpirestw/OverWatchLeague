//
//  TeamsPresenter.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 02/10/20.
//

import Foundation

class TeamsPresenter {

    var interactor = TeamInteractor()
    var reloadTableViewClosure: (()->())?
    var cellPresenter = [TeamWire]() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }

    var numberOfCells: Int {
        return cellPresenter.count
    }

    var cellHeight: Int {
        return 100
    }

    func getcellPresenter( at indexPath: IndexPath ) -> TeamWire {
        return cellPresenter[indexPath.row]
    }

    func updateView() {
        interactor.interactorDelegate = self
        interactor.getTeams()
    }
}

extension TeamsPresenter: InteractorDelegate {
    func didUpdateTeamList(team: [TeamWire]) {
        cellPresenter = team
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
