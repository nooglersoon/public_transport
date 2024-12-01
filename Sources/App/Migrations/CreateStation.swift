//
//  CreateStation.swift
//  public_transport
//
//  Created by Fauzi Achmad on 01/12/24.
//

import Fluent

// MARK: - Station Migration
public struct CreateStation: AsyncMigration {
    public func prepare(on database: Database) async throws {
        try await database.schema("stations")
            .id()
            .field("name", .string, .required)
            .field("corridor", .string, .required)
            .field("latitude", .double, .required)
            .field("longitude", .double, .required)
            .field("retails", .array(of: .string), .required)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    public func revert(on database: Database) async throws {
        try await database.schema("stations").delete()
    }
}
