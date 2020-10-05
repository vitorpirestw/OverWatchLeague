//
//  TeamInteractor.swift
//  OverWatchLeague
//
//  Created by LAVitor Pires on 02/10/20.
//

import Foundation

protocol InteractorDelegate {
    func didUpdateTeamList(team: [TeamWire])
    func didFailWithError(error: Error)
}

class TeamInteractor {

     var interactorDelegate: InteractorDelegate?
     let baseURL = "https://api.overwatchleague.com/v2/teams"

    func getTeams() {

        let urlString = baseURL
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.interactorDelegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let team = self.parseJSON(safeData) {
                        self.interactorDelegate?.didUpdateTeamList(team: team)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ teamData: Data) -> [TeamWire]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TeamRepository.self, from: teamData)
            let teams = decodedData.data
            return teams

        } catch {
           interactorDelegate?.didFailWithError(error: error)
            return nil
        }
    }
}
