//
//  NetworkError.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 22/4/22.
//

import Foundation

enum NetworkError: Error {
    case networkUnreachable
    case accepted
    case requestError
}

extension NetworkError: CustomStringConvertible{
    public var description: String{
        switch self{
        case .networkUnreachable:
            return "Imposible acceder, compruebe su conexión"
        case .accepted:
            return "Ha ocurrido un error"
        case.requestError:
            return "No se puede acceder a los servidores en estos momentos"
        }
    }
}
