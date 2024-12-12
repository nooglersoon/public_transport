import Foundation
import Vapor

func routes(_ app: Application) throws {
        
    /// Public Stations
    app.group("stations") { stations in
        stations.group(":id") { station in
            
            /// [PUT] /stations/:id
            /// Edit a station's details
            station.put { request -> String in
                
                guard let id = request.parameters.get("id") else {
                    throw Abort(.badRequest, reason: "Missing station id")
                }
                
                return "ok"
            }
        }
    }
    
    try app.register(collection: StationsController())
    
}
