//
//  MRTStationsController.swift
//  public_transport
//
//  Created by Fauzi Achmad on 20/11/24.
//

import Vapor

struct StationsController: RouteCollection {
    
    func boot(routes: any RoutesBuilder) throws {
        
        // Main Routes
        let todos = routes.grouped("stations")
        
        /// [GET] /stations
        /// Return the list of stations
        todos.get(use: getAllStations)
//        todos.post(use: create)
        
        todos.group(":id") { todo in
//            todo.get(use: show)
//            todo.put(use: update)
//            todo.delete(use: delete)
        }
        
    }
    
}

// MARK: - Extensions
extension StationsController {
    @Sendable
    func getAllStations(_ request: Request) async throws -> [StationResponse] {
        let queriedStations = try await Station.query(on: request.db).all()
        let stations: [StationResponse] =  queriedStations.map({$0.mapToStationResponse()})
        return stations
    }
}
