//
//  FFDataSource.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 21/12/20.
//

import Foundation


class FootballFactsDataSource{
    
    typealias FetchComplete = (Bool) -> Void
    typealias Failure = (String) -> Void
    
    class func fetchCompetitions(completion: @escaping FetchComplete, failure: @escaping Failure){
        if FootballFactsUtility.isNetworkReachable(){
            FootballFactsServices.requestLeague { (result) in
                completion(true)
            } failure: { (_) in
                completion(true)
            }
        }else{
            completion(true)
        }
    }
    
    class func fetchLeagueTitle(leagueID: Int, completion: @escaping FetchComplete, failure: @escaping Failure){
        if FootballFactsUtility.isNetworkReachable(){
            FootballFactsServices.requestLeagueStandings(leagueId: leagueID) { (result) in
                completion(true)
            } failure: { (_) in
                completion(true)
            }
        }else{
            completion(true)
        }
    }
}
