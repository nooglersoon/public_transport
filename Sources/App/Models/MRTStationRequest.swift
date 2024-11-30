//
//  AddMRTRequest.swift
//  public_transport
//
//  Created by Fauzi Achmad on 20/11/24.
//

import Vapor

public struct MRTStationRequest: Content {
    public var name: String
    public var latitude: Double
    public var longitude: Double
    
    // Runs after this Content is decoded. `mutating` is only required for structs, not classes.
    mutating public func afterDecode() throws {
        // Name must be passed in, but can't be an empty string.
        self.name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        if name.isEmpty {
            throw Abort(.badRequest, reason: "Name must not be empty.")
        }
    }

    // Runs before this Content is encoded. `mutating` is only required for structs, not classes.
    mutating public func beforeEncode() throws {
        // Have to *always* pass a name back, and it can't be an empty string.
        let name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !name.isEmpty {
            throw Abort(.badRequest, reason: "Name must not be empty.")
        }
        
        self.name = name
    }
    
}
