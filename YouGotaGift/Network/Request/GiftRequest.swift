//
//  GiftRequest.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import Foundation

struct GiftRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}
extension GiftRequest: NetworkRequest {

    typealias Model = Gift
    func decode(_ data: Data) -> Gift? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return try? decoder.decode(Gift.self, from: data)
    }

    func execute(withCompletion completion: @escaping (Result<Model?, Error>) -> Void) {
        load(resource: resource, withCompletion: completion)
    }

}
