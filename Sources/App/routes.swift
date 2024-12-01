import Foundation
import Vapor

func routes(_ app: Application) throws {
        
    /// Public Stations
    app.group("stations") { stations in
        /// [POST] /stations
        /// Add a new station
        stations.post { request -> String in
            return "ok"
        }
        
        stations.group(":id") { station in
            
            /// [GET] /stations/:id
            /// Return specific station details
            station.get { request -> StationResponse in
                
                guard let id = request.parameters.get("id") else {
                    throw Abort(.badRequest, reason: "Missing station id")
                }
                let station = try request.content.decode(StationResponse.self)
                return station
            }
            
            /// [PUT] /stations/:id
            /// Edit a station's details
            station.put { request -> String in
                
                guard let id = request.parameters.get("id") else {
                    throw Abort(.badRequest, reason: "Missing station id")
                }
                
                return "ok"
            }
            
            /// [DELETE] /stations/:id
            /// Delete a station
            station.delete { request -> String in
                
                guard let id = request.parameters.get("id") else {
                    throw Abort(.badRequest, reason: "Missing station id")
                }
                
                return "ok"
            }
        }
    }
    
    try app.register(collection: StationsController())
    
}
