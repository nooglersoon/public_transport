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
            
            /// [GET] /stations/:id
            /// Return the station with the given id
            todo.get(use: getStation)
//            todo.put(use: update)
            todo.delete(use: deleteStation)
        }
        
    }
    
}

// MARK: - Extensions
extension StationsController {
    @Sendable
    func getAllStations(_ request: Request) async throws -> GenericResponse<[StationResponse]> {
        let queriedStations = try await Station.query(on: request.db).all()
        let stations: [StationResponse] =  queriedStations.map({$0.response})
        return .init(data: stations, status: 200, message: "Success")
    }
    
    @Sendable
    func createNewStation(_ request: Request) async throws -> GenericResponse<StationResponse> {
        try StationRequest.validate(content: request)
        let newStation = try request.content.decode(StationRequest.self)
        let station = Station(id: newStation.id, name: newStation.name, corridor: newStation.corridor, latitude: newStation.latitude, longitude: newStation.longitude, retails: [])
        do {
            try await station.create(on: request.db)
            guard let station = try await Station.find(newStation.id, on: request.db) else {
                throw Abort(.internalServerError, reason: "Failed to create new station")
            }
            return .init(data: station.response, status: 200, message: "Success")
        } catch {
            throw Abort(.internalServerError, reason: "Failed to create new station")
        }
    }
    
    @Sendable
    func getStation(_ request: Request) async throws -> GenericResponse<StationResponse> {
        guard let stationId = request.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest, reason: "Station id is not provided or invalid")
        }
        guard let station = try await Station.find(stationId, on: request.db) else {
            throw Abort(.notFound, reason: "Station is not found")
        }
        return .init(data: station.response, status: 200, message: "Success")
    }
    
    @Sendable
    func deleteStation(_ request: Request) async throws -> GenericResponse<EmptyResponse> {
        guard let stationId = request.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest, reason: "Station id is not provided or invalid")
        }
        
        guard let station = try await Station.find(stationId, on: request.db) else {
            throw Abort(.notFound, reason: "Station is not found")
        }
        
        do {
            try await station.delete(on: request.db)
            return .init(data: nil, status: 200, message: "Success")
        } catch {
            throw Abort(.internalServerError, reason: "Failed to Delete Station")
        }
    }
}
