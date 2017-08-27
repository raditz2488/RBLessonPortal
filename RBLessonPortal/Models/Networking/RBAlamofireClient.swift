//
//  RBAlamofireClient.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation
import Alamofire

protocol RBDataRequestProtocol {
    func responseJSON(queue: DispatchQueue?, options: JSONSerialization.ReadingOptions, completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self
}

class RBAlamofireClient {
    // MARK: Properties
    var requestClosure: ((URLConvertible, HTTPMethod, Parameters?, ParameterEncoding, HTTPHeaders?) -> RBDataRequestProtocol)!
    var requestCount: Int = 0 {
        willSet(newCount) {
            if newCount > 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    // MARK: Initializers
    init() {
        requestClosure = Alamofire.request
    }
}

extension RBAlamofireClient: RBHttpClient {
    func postAccessToken(forUserName userName: String, password: String, completionHandler:@escaping RBRequestCompletionHandler)  {
        let parameters = [RBKeys.username: userName, RBKeys.password: password, RBKeys.granttype: RBGrantType.password, RBKeys.scope: RBScope.user]
        let headers = [RBHttpHeaderKeys.contentType: RBHttpContentTypeValues.applicationFormURLEncoded]
        let dataRequest = requestClosure(RBWebServices.accessToken.url, .post, parameters, URLEncoding.default, headers)
//        _ = dataRequest.responseJSON(queue: nil, options: .allowFragments) { (dataResponse) in
//            completionHandler(dataResponse.response, dataResponse.result.value, dataResponse.error)
//        }
        fireDataRequest(dataRequest, completionHandler: completionHandler)
    }
    
    func getCurrentUser(fromAccessToken accessToken: String, completionHandler: @escaping RBRequestCompletionHandler) {
        let headers = [RBHttpHeaderKeys.authorization : "Bearer \(accessToken)", RBHttpHeaderKeys.contentType : RBHttpContentTypeValues.applicationJson]
        let dataRequest = requestClosure(RBWebServices.currentUser.url, .get, nil, JSONEncoding.default, headers)
//        _ = dataRequest.responseJSON(queue: nil, options: .allowFragments, completionHandler: { (dataResponse) in
//            completionHandler(dataResponse.response, dataResponse.result.value, dataResponse.error)
//        })
        fireDataRequest(dataRequest, completionHandler: completionHandler)
    }
    
    func getUserProfile(forID id: String, companyID: String, accessToken: String, completionHandler: @escaping RBRequestCompletionHandler) {
        let headers = [RBHttpHeaderKeys.authorization : "Bearer \(accessToken)"]
        let url = RBWebServices.userProfile(userID: id, companyID: companyID).url
        let dataRequest = requestClosure(url, .get, nil, JSONEncoding.default, headers)
//        _ = dataRequest.responseJSON(queue: nil, options: .allowFragments, completionHandler: { (dataResponse) in
//            completionHandler(dataResponse.response, dataResponse.result.value, dataResponse.error)
//        })
        fireDataRequest(dataRequest, completionHandler: completionHandler)
    }
    
    func postRefreshTokenRequest(withRefreshToken refreshToken: String, completionHandler: @escaping RBRequestCompletionHandler) {
        let parameters = [RBKeys.refreshtoken: refreshToken, RBKeys.granttype: RBGrantType.refreshtoken, RBKeys.scope: RBScope.user]
        let headers = [RBHttpHeaderKeys.contentType: RBHttpContentTypeValues.applicationFormURLEncoded]
        let dataRequest = requestClosure(RBWebServices.accessToken.url, .post, parameters, URLEncoding.default, headers)
//        _ = dataRequest.responseJSON(queue: nil, options: .allowFragments) { (dataResponse) in
//            completionHandler(dataResponse.response, dataResponse.result.value, dataResponse.error)
//        }
        fireDataRequest(dataRequest, completionHandler: completionHandler)
    }
    
    func fireDataRequest(_ dataRequest: RBDataRequestProtocol, completionHandler:@escaping RBRequestCompletionHandler) {
        requestCount += 1
        _ = dataRequest.responseJSON(queue: nil, options: .allowFragments) { [weak self] (dataResponse) in
            completionHandler(dataResponse.response, dataResponse.result.value, dataResponse.error)
            self?.requestCount -= 1
        }
    }
}

extension DataRequest: RBDataRequestProtocol { }
