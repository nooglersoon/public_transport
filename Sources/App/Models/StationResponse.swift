//
//  StationResponse.swift
//  public_transport
//
//  Created by Fauzi Achmad on 30/11/24.
//

import Foundation
import Vapor
import Fluent

public struct StationResponse: Content {
    public let id: UUID
    public let name: String
    public let corridor: String
    public let transportType: String
    public let latitude: Double
    public let longitude: Double
    public let retails: [String]
    public let coworkingSpaces: [String]
    public let stays: [String]
    public let amenities: [String]
    public let intermodalTransports: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case corridor
        case transportType = "transport_type"
        case latitude
        case longitude
        case retails
        case coworkingSpaces = "coworking_spaces"
        case stays
        case amenities
        case intermodalTransports = "intermodal_transports"
    }
    
}

public final class Station: Model, Content {
    
    public static let schema: String = "stations"
    
    // Unique identifier for this Station.
    @ID(custom: "id") // This will now use an integer id with autoincrement
    public var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "corridor")
    var corridor: String
    
    @Field(key: "latitude")
    var latitude: Double
    
    @Field(key: "longitude")
    var longitude: Double
    
//    // Reference to the Galaxy this Star is in.
//    @Parent(key: "transport_type_id")
//    var transportType: TransportType
    
    public init() { }
    
    public init(
        id: Int,
        name: String,
        corridor: String,
        latitude: Double,
        longitude: Double
//        transportTypeID: UUID
    ) {
        self.id = id
        self.name = name
        self.corridor = corridor
        self.latitude = latitude
        self.longitude = longitude
//        self.$transportType.id = transportTypeID
    }
    
}

// MARK: - Station Migration
public struct CreateStation: AsyncMigration {
    // Prepares the database for storing Galaxy models.
        public func prepare(on database: Database) async throws {
            try await database.schema("stations")
                .id()
                .field("name", .string)
                .field("corridor", .string)
                .field("latitude", .double)
                .field("longitude", .double)
                .create()
        }

        // Optionally reverts the changes made in the prepare method.
        public func revert(on database: Database) async throws {
            try await database.schema("stations").delete()
        }
}

public final class TransportType: Model {
    
    public static let schema: String = "transport_types"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    public init() { }
    
    public init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
}