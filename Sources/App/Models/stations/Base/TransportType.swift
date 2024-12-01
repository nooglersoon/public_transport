//
//  TransportType.swift
//  public_transport
//
//  Created by Fauzi Achmad on 01/12/24.
//

import Foundation
import Fluent

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
