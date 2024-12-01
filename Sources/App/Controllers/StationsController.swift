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
        
        /// [POST] /stations
        /// Add a new station
        todos.post(use: createNewStation)
        
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
    
    @Sendable
    func createNewStation(_ request: Request) async throws -> StationResponse {
        try StationRequest.validate(content: request)
        let newStation = try request.content.decode(StationRequest.self)
        let station = Station(id: newStation.id, name: newStation.name, corridor: newStation.corridor, latitude: newStation.latitude, longitude: newStation.longitude, retails: [])
        do {
            try await station.create(on: request.db)
            guard let station = try await Station.find(newStation.id, on: request.db) else {
                throw Abort(.internalServerError, reason: "Failed to create new station")
            }
            return station.mapToStationResponse()
        } catch {
            throw Abort(.internalServerError, reason: "Failed to create new station")
        }
    }
}
