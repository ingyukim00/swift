//
//  Predators.swift
//  JPApexPredators
//
//  Created by Ingyu Kim on 10/25/25.
//

import Foundation

class Predators {
    var allApepxPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
//        print("apexPredators count:", apexPredators.count)
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // snakecase to camel
                allApepxPredators = try decoder.decode([ApexPredator].self, from: data)
            } catch {
              print("Error decoding JSON data", error)
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
            if searchTerm.isEmpty {
                return apexPredators
            } else {
                return apexPredators.filter {
                    predator in predator.name.localizedCaseInsensitiveContains(searchTerm)
                }
            }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter (by type: APType) {
        if type == .all {
            return apexPredators = allApepxPredators
        } else {
            apexPredators = allApepxPredators.filter({ ApexPredator in
                ApexPredator.type == type
            })
        }
    }
}
