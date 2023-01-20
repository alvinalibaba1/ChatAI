//
//  OpenAISwift.swift
//  ChatAI
//
//  Created by temp on 20/01/23.
//

import Foundation
import OpenAISwift

final class APICaller {
    static let shared = APICaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String ,completion: @escaping (Result<String , Error>) -> Void) {
        client?.sendCompletion(with: input, model: .codex(.davinci),completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
