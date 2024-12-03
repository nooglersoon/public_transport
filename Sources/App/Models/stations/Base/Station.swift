//
//  Station.swift
//  public_transport
//
//  Created by Fauzi Achmad on 01/12/24.
//

import Fluent

public final class Station: Model {
    
    public static let schema: String = "stations"
    
    // Unique identifier for this Station.
    @ID(custom: "id", generatedBy: .database) // This will now use an integer id with autoincrement
    public var id: Int?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "corridor")
    var corridor: String
    
    @Field(key: "latitude")
    var latitude: Double
    
    @Field(key: "longitude")
    var longitude: Double
    
    @Field(key: "retails")
    var retails: [String]
    
    //    // Reference to the Galaxy this Star is in.
    //    @Parent(key: "transport_type_id")
    //    var transportType: TransportType
    
    public init() { }
    
    public init(
        id: Int,
        name: String,
        corridor: String,
        latitude: Double,
        longitude: Double,
        retails: [String]
        //        transportTypeID: UUID
    ) {
        self.id = id
        self.name = name
        self.corridor = corridor
        self.latitude = latitude
        self.longitude = longitude
        self.retails = retails
        //        self.$transportType.id = transportTypeID
    }
    
}

// MARK: - Map to DTO

public extension Station {
    var response: StationResponse {
        .init(
            id: id ?? 0,
            name: name,
            corridor: corridor,
            transportType: "MRT",
            latitude: latitude,
            longitude: longitude,
            retails: retails
        )
    }
}
