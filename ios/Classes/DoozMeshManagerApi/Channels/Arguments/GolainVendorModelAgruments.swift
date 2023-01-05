import Foundation

struct GolainVendorModelArguments: BaseFlutterArguments {
    let opCode : Int
    // let companyIdentifier : UInt16
    let address : Int
    let message : Data

    init(_ arguments:FlutterCallArguments?) throws {
        guard let _arguments = arguments else{
            throw FlutterCallError.missingArguments
        }
        guard
            let opCode = _arguments["opCode"] as? Int,
            let address = _arguments["address"] as? Int,
            let message = _arguments["message"] as? FlutterStandardTypedData
        else{
            throw FlutterCallError.errorDecoding
        }
        self.opCode = opCode
        // self.companyIdentifier = companyIdentifier
        self.address = address
        self.message = Data(message.data)
    }
}
