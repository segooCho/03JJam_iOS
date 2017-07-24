//
//  MappingError.swift
//  JJam
//
//  Created by admin on 2017. 7. 21..
//  Copyright © 2017년 admin. All rights reserved.
//

struct MappingError: Error, CustomStringConvertible {
    
    let description: String
    
    init(from: Any?, to: Any.Type) {
        self.description = "Failed to map \(from) to \(to)"
    }
}

