//
//  GenericResponse.swift
//  public_transport
//
//  Created by Fauzi Achmad on 03/12/24.
//

import Vapor

public struct GenericResponse<T: Content>: Content {
    public var data: T?
    public var status: Int
    public var message: String
    
    public init(data: T?, status: Int, message: String) {
        self.data = data
        self.status = status
        self.message = message
    }
}

public struct EmptyResponse: Content {}
