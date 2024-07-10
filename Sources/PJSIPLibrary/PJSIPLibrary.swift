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
        //Create Lib
        CPPWrapper().createLibWrapper()
        
        // Listen incoming call via function pointer
        CPPWrapper().incoming_call_wrapper({ () -> Void in
            self.delegate?.incomingCallReceived(callId: self.getIncomingCallId())
        })
        
        // Listen incoming call via function pointer
        CPPWrapper().acc_listener_wrapper({ (status: Bool) -> Void in
            self.delegate?.acccountUpdateReceived(status: status)
        })
        
        // Listen incoming & outgoing call status
        CPPWrapper().call_listener_wrapper({ (call_answer_code: Int32) -> Void in
            self.delegate?.callStatusRecieved(status: Int(call_answer_code))
        })
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
}
