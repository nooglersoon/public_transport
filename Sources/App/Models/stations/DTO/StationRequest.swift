//
//  StationResponse 2.swift
//  public_transport
//
//  Created by Fauzi Achmad on 01/12/24.
//

import Foundation

public struct StationRequest: Codable {
    public let id: Int
    public let name: String
    public let corridor: String
    public let transportType: String
    public let latitude: Double
    public let longitude: Double
    public let retails: [String]
    //    public let coworkingSpaces: [String]
    //    public let stays: [String]
    //    public let amenities: [String]
    //    public let intermodalTransports: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case corridor
        case transportType = "transport_type"
        case latitude
        case longitude
        case retails
        //        case coworkingSpaces = "coworking_spaces"
        //        case stays
        //        case amenities
        //        case intermodalTransports = "intermodal_transports"
    }
    
}
