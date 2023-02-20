//
//  GolainVendorModelGetArguments.swift
//  nordic_nrf_mesh
//
//  Created by Atharv Bhadange on 16/02/23.
//

import Foundation

struct GolainVendorModelGetArguments: BaseFlutterArguments {
    let opCode : UInt8
    let companyIdentifier : UInt16
    let address : Int
    let message : Data
    let modelId: Int
    let keyIndex: Int

    init(_ arguments:FlutterCallArguments?) throws {
        guard let _arguments = arguments else{
            throw FlutterCallError.missingArguments
        }
        guard
            let opCode = _arguments["opCode"] as? UInt8,
            let address = _arguments["address"] as? Int,
            let message = _arguments["byteData"] as? FlutterStandardTypedData,
            let companyId = _arguments["companyId"] as? UInt16,
            let modelId = _arguments["modelId"] as? Int,
            let keyIndex = _arguments["keyIndex"] as? Int
        else{
            throw FlutterCallError.errorDecoding
        }
        self.opCode = opCode
        self.address = address
        self.message = Data(message.data)
        self.companyIdentifier = companyId
        self.modelId = modelId
        self.keyIndex = keyIndex
    }
}
