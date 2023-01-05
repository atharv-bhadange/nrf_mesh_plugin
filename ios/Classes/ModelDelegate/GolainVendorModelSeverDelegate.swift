// import Foundation
// import nRFMeshProvision

// class GolainVendorModelServerDelegate: ModelDelegate {
//     let messageTypes: [UInt32 : MeshMessage.Type]
//     let isSubscriptionSupported: Bool = true
//     var publicationMessageComposer: MessageComposer?

//     private var lastTransaction: (source: Address, destination: MeshAddress, tid: UInt8, timestamp: Date)?

//     init() {
//         let types: [VendorMessage.Type] = [
//             GolainVendorModelSet.self
//         ]
//         messageTypes = types.toMap()
//     }

//     func model(_ model: Model, didReceiveAcknowledgedMessage request: AcknowledgedMeshMessage, from source: Address, sentTo destination: MeshAddress) -> MeshMessage {
//         switch request {
//         case let request as GolainVendorModelSet:
//             guard lastTransaction == nil ||
//                   lastTransaction!.source != source || lastTransaction!.destination != destination ||
//                   request.isNewTransaction(previousTid: lastTransaction!.tid, timestamp: lastTransaction!.timestamp) else {
//                 lastTransaction = (source: source, destination: destination, tid: request.tid, timestamp: Date())
//                 break
//             }
//             lastTransaction = (source: source, destination: destination, tid: request.tid, timestamp: Date())
//             // state = GenericState<Bool>(request.isOn)
//             return GenericOnOffStatus(opCode: request.opCode, message: request.message)
//         default:
//             // return GenericOnOffStatus(state)
//             break
//         }
//     }
// }
