// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Pjsua2

protocol PJSIPLibraryDelegate: AnyObject {
    func incomingCallReceived(callId: String)
    
    func acccountUpdateReceived(status: Bool)
    
    func callStatusRecieved(status: Int)
}

public struct PJSIPLibrary {
    
    // Delegate property
    private weak var delegate: PJSIPLibraryDelegate?
    
    init() {
        CPPWrapper().createLibWrapper()
    }

    func answerCall() {
        CPPWrapper().answerCall()
    }
    
    func hangupCall() {
        CPPWrapper().hangupCall()
    }
    
    func holdCall() {
        CPPWrapper().holdCall()
    }
    
    func unholdCall() {
        CPPWrapper().unholdCall()
    }
    
    func getIncomingCallId() -> String {
       return CPPWrapper().incomingCallInfoWrapper()
    }
    
    func call(uri: String) {
        CPPWrapper().outgoingCall(uri)
    }
    
    func login(username: String, password: String, domain: String, port: String = "5060") {
        CPPWrapper().createAccountWrapper(username, password, domain, port);
    }
    
    func logout() {
        CPPWrapper().unregisterAccountWrapper()
    }
    
    private func incoming_call_swift() {
        self.delegate?.incomingCallReceived(callId: self.getIncomingCallId())
    }
    
    private func acc_listener_swift(status: Bool) {
        self.delegate?.acccountUpdateReceived(status: status)
    }
    
    private func call_status_listener_swift ( call_answer_code: Int32) {
        self.delegate?.callStatusRecieved(status: Int(call_answer_code))
    }
    
}
