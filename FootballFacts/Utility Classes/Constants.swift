//
//  File.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 21/12/20.
//

import Foundation
import Alamofire


struct Constants {
    static let dataModelName = "FootballFacts"
    static let competitionsBaseUrlString = "https://api.football-data.org/v2/competitions"
    static let api_header : HTTPHeaders = ["X-Auth-Token" : "6175be159ddc40a5bc3c0f615c1ece54"]
    static let errorInFetch = "Error in fetch from server"
}
