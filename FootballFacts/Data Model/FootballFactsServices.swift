//
//  FootballFactsServices.swift
//  FootballFacts
//
//  Created by Harsh Saxena on 21/12/20.
//

import Foundation
import Alamofire


class FootballFactsServices{
    typealias SaveComplete = (Bool) -> Void
    typealias Failure = (String) -> Void
 //   CompetitionList -> Standings -> Team
    class func requestLeague(completion:@escaping SaveComplete, failure: @escaping Failure){
        let url = URL(string: Constants.competitionsBaseUrlString)
        AF.request(url!, method: .get, headers: Constants.api_header).responseJSON { (dataResponse) in
            if let responseCode = dataResponse.response?.statusCode, responseCode != 200 || responseCode != 201 {
                failure("message")
            }
            do {
                let jsonResponse =  try JSONSerialization.jsonObject(with: dataResponse.data!, options: .mutableLeaves) as! [String:Any]
                print(jsonResponse)
                let childContext = CoreDataPrivateContext(concurrencyType: .privateQueueConcurrencyType)
                childContext.parent = CoreDataManager.sharedInstance.managedObjectContext
                childContext.perform {
                    childContext.deleteCompetitions()
                    childContext.saveCompetitionsData(jsonResponse: jsonResponse)
                    childContext.saveContext()
                    CoreDataManager.sharedInstance.managedObjectContext.performAndWait {
                        CoreDataManager.sharedInstance.saveContext()
                        completion(true)
                    }

                }
            }catch{
                fatalError()
            }
        }
        
    }
    
    class func requestLeagueStandings(leagueId: Int, completion:@escaping SaveComplete, failure: @escaping Failure){
        let url = URL(string: Constants.competitionsBaseUrlString + "/\(leagueId)/standings?standingType=TOTAL")
        AF.request(url!, method: .get, headers: Constants.api_header ).responseJSON { (dataResponse) in
            guard let responseCode = dataResponse.response?.statusCode, responseCode != 200 || responseCode != 201  else{
                failure("Problem")
                return
            }
            do {
                let jsonResponse =  try JSONSerialization.jsonObject(with: dataResponse.data!, options: .mutableLeaves) as! [String:Any]
                print(jsonResponse)
                
                let childContext = CoreDataPrivateContext(concurrencyType: .privateQueueConcurrencyType)
                childContext.parent = CoreDataManager.sharedInstance.managedObjectContext
                childContext.perform {
                    childContext.deleteStandings(leagueId: leagueId)
                    childContext.saveLeagueData(jsonResponse: jsonResponse, leagueId: leagueId)
                    childContext.saveContext()
                    CoreDataManager.sharedInstance.managedObjectContext.performAndWait{
                        CoreDataManager.sharedInstance.saveContext()
                        completion(true)
                    }
                }
            }catch{
                fatalError()
            }
        }
    }
    
    class func getCrestImage(_ urlString: String, completion:@escaping(_ image: UIImage)-> Void, failure: @escaping Failure){
        // Did not work for SVG
        let url = URL(string: urlString)
        AF.request(url!).responseData { (dataResponse) in
            let data = dataResponse.data
            if let data = data{
                let image = UIImage(data: data)
                completion(image!)

            }
        }
    }
}
