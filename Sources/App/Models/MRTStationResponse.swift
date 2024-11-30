//
//  MRTStation.swift
//  public_transport
//
//  Created by Fauzi Achmad on 26/11/24.
//

import Foundation
import Vapor

struct MRTStationResponse: Content {
    let id: UUID
    let name: String
    let location: Location
    let lines: [Line]

    enum CodingKeys: String, CodingKey {
        case id, name, location, lines
    }
}

struct Location: Content {
    let latitude: Double
    let longitude: Double
    // Add other location details as needed
}

struct Line: Content {
    let name: String
    let color: String // Or a more complex color representation
    // Add other line details as needed
}
