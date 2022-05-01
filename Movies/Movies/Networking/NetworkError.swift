//
//  NetworkError.swift
//  Movies
//
//  Created by Pierre Chamorro on 1/05/22.
//

import Foundation
enum NetworkError: String, Error{
    case invalidURL
    case serializationFailed
    case generic
    case couldNotDecodeData
    case httpResponseError
    case statusCodeError = "Ocurrió un error, vuelva intentar luego"
    case jsonDecoder = "Error al intentar extraer datos de json."
    case unauthorized
}
