import Foundation
import Vapor

func routes(_ app: Application) throws {
    
    /// Public Stations
    app.group("stations") { stations in
        /// [GET] /stations
        /// Return the list of stations
        stations.get { request -> [Station] in
            
            let db = request.db
            let stations = try await Station.query(on: db).all()
            
            print(stations)
            
            return stations
        }
        
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
    
    /// [GET] mrt/station/:id
    /// Return the list of mrt stations
    
    /// MRT Stations Routes
    app.group("mrt","stations") { stations in
        /// [GET] mrt/stations
        /// Return the list of mrt stations
        stations.get { request -> [MRTStationResponse] in
            
            // Return specific corridor/section
            let corridor = request.query[String.self, at: "corridor"]
            
            //            if let corridor {
            //                if corridor == "north_south" {
            //                    return "Kota to Fatmawati"
            //                } else if corridor == "east_west" {
            //                    return "Balaraja to Medan Satria"
            //                }
            //            }
            
            return [
                .init(id: UUID(), name: "Bundaran HI", location: .init(latitude: 0.0, longitude: 0.0), lines: [.init(name: "north_south", color: "Red")])
            ]
        }
        
        /// [POST] mrt/stations
        /// Add new station
        stations.post { request in
            let mrtStationRequest = try request.content.decode(MRTStationRequest.self)
            return "New MRT Station Added with name: \(mrtStationRequest.name)"
        }
    }
    
    app.group("mrt","station",":id") { station in
        
        /// [GET] mrt/stations/:id
        /// Get Specific MRT with the given id
        station.get { request in
            // early checking to makesure the given id match with the specific type based on the requirement
            guard let stationID = request.parameters.get("id", as: Int.self) else {
                throw Abort(.badRequest, reason: "Invalid station id")
            }
            return stationID
        }
        
        /// [PUT] mrt/stations/:id
        /// Update Specific MRT with the given id
        station.put { request in
            // early checking to makesure the given id match with the specific type based on the requirement
            guard let stationID = request.parameters.get("id", as: Int.self) else {
                throw Abort(.badRequest, reason: "Invalid station id")
            }
            return stationID
        }
    }
}
