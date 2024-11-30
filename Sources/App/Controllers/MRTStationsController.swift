//
//  MRTStationsController.swift
//  public_transport
//
//  Created by Fauzi Achmad on 20/11/24.
//

import Vapor

struct MRTStationsController: RouteCollection {
    // The entry point for controller
    func boot(routes: RoutesBuilder) throws {
        
        let stations = routes.grouped("mrt","stations")
//        stations.get(use: index)
//        stations.post(use: create)

        let station = routes.grouped("mrt","station")
        station.group(":id") { todo in
//            todo.get(use: show)
//            todo.put(use: update)
//            todo.delete(use: delete)
        }
        
    }
    
    
}
