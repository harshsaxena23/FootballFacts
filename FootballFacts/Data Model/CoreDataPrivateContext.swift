//
//  CoreDataPrivateContext.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 21/12/20.
//

import Foundation
import CoreData


class CoreDataPrivateContext: NSManagedObjectContext{
    func saveContext() {
        if self.hasChanges {
            do {
                try self.save()
            } catch {
                let error = error as NSError
                print(error.userInfo)
                abort()
            }
        }
    }
    
    func saveCompetitionsData(jsonResponse : [String:Any]){
       
        let competitonsArray = jsonResponse["competitions"] as! [[String:Any]]
        for comp in competitonsArray{
            let entity = NSEntityDescription.entity(forEntityName: "Competitions", in: self)
            let competitionsList = Competitions(entity: entity!, insertInto: self)
            let area = comp["area"] as! NSDictionary
            competitionsList.country = (area["name"] as! String)
            competitionsList.id = Int16(comp["id"] as! Int)
            competitionsList.emblem_url = (comp["emblemUrl"] as? String)
            competitionsList.code = (area["countryCode"] as! String)
            competitionsList.name = (comp["name"] as! String)
        }
        
    }
    
    func deleteCompetitions(){
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Competitions")
        deleteFetch.includesSubentities = false
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try self.execute(deleteRequest)
            try self.save()
        } catch {
            //print ("There was an error")
        }
    }
    
    
    func saveLeagueData(jsonResponse: [String:Any], leagueId: Int){
        let standingsDict = jsonResponse["standings"] as! [[String:Any]]
        let standingsArray = standingsDict[0]["table"] as! [[String:Any]]
        for standing in standingsArray{
            let entity = NSEntityDescription.entity(forEntityName: "Standings", in: self)
            let standingsList = Standings(entity: entity!, insertInto: self)
            standingsList.position = (standing["position"] as! Int16)
            standingsList.played_games = (standing["playedGames"] as! Int16)
            standingsList.form = (standing["form"] as! String)
            standingsList.won = (standing["won"] as! Int16)
            standingsList.lost = (standing["lost"] as! Int16)
            standingsList.draw = (standing["draw"] as! Int16)
            standingsList.points = (standing["points"] as! Int16)
            standingsList.goalsFor = (standing["goalsFor"] as! Int16)
            standingsList.goalsAgainst = (standing["goalsAgainst"] as! Int16)
            standingsList.goalsDifference = (standing["goalDifference"] as! Int16)
            let team = (standing["team"] as! [String:Any])
            standingsList.team_id = (team["id"] as! Int16)
            standingsList.crest_url = (team["crestUrl"] as! String)
            standingsList.name = (team["name"] as! String)
            standingsList.league_id = Int16(leagueId)
        }
        
    }
    
    func deleteStandings(leagueId: Int){
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Standings")
        deleteFetch.predicate = NSPredicate(format: "league_id==\(leagueId)")
        deleteFetch.includesSubentities = false
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try self.execute(deleteRequest)
            try self.save()
        } catch {
            //print ("There was an error")
        }
    }
}
