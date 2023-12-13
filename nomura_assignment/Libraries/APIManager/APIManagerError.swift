//
//  APIManagerError.swift
//  nomura_assignment
//
//  Created by OSLT-0076 on 13/12/23.
//

import Foundation

enum APIManagerError: Error {
    case apiErrorWithCustomMessage(code: Int, message: String?)
}


extension APIManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .apiErrorWithCustomMessage(_, let message):
            return NSLocalizedString(message ?? "APIManagerError generic error!", comment: "APIManagerError custom error.")
        }
    }
}

enum APIManagerErrorCodes {
    
    
}
