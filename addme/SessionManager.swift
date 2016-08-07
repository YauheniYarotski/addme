import Foundation
import MultipeerConnectivity

protocol SessionManagerDelegate {
    
    func connectedDevicesChanged(manager : SessionManager, connectedDevices: [String])
    func didRecivePerson(manager: SessionManager, person: Person)
//    func didConnectDevice(manage: SessionManager, devicePerson: Person)
    func didDiconectDevice(manage: SessionManager)
    
}

class SessionManager : NSObject {
    
    private let ColorServiceType = "example-color"
    private let myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    let serviceAdvertiser : MCNearbyServiceAdvertiser
    let serviceBrowser : MCNearbyServiceBrowser
    var delegate : SessionManagerDelegate?
    let me = fackePrsones[SessionManager.randRange(0, upper: fackePrsones.count - 1)]
    var outsidePersons = [Person]()
    var timer: NSTimer!
    
    
    static private let fackePrsones: [Person] = {
        let person1 = Person(name: "Yauheni Dzemiashkevich", contacts: [Contact(name:"fb", url: "http://facebook.com"), Contact(name:"vk", url: "http://facebook.com")], image: UIImage(named: "avatar"), descriptionName: "iOS Developre at Add Me" )
        let person2 = Person(name: "Yauheni Yarotski", contacts: [Contact(name:"fb", url: "http://facebook.com"), Contact(name:"vk", url: "http://facebook.com")], image: UIImage(named: "avatar2"), descriptionName: "iOS Developre at Add Me")
        let person3 = Person(name: "Alex Cvirko", contacts: [Contact(name:"fb", url: "http://facebook.com"), Contact(name:"vk", url: "http://facebook.com")], image: UIImage(named: "avatar3"), descriptionName: "Designer at Add Me")
        let person4 = Person(name: "Vladimir Hudnitski", contacts: [Contact(name:"fb", url: "http://facebook.com"), Contact(name:"vk", url: "http://facebook.com")], image: UIImage(named: "avatar4"), descriptionName: "Android Developre at RubyRoid Labs")
        return [person1, person2, person3, person4]
    }()
    
    static func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ColorServiceType)
        
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ColorServiceType)
        
        super.init()
        
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(SessionManager.tick), userInfo: nil, repeats: true)
            }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    lazy var session: MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.Required)
        session.delegate = self
        return session
    }()
    
    func sendMyContact() {
        if session.connectedPeers.count > 0 {
            var error : NSError?
            do {
                let data = NSKeyedArchiver.archivedDataWithRootObject(me)
                try self.session.sendData(data, toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
            } catch var error1 as NSError {
                error = error1
                NSLog("%@", "\(error)")
            }
        }
    }
    
    //MARK: - Timer
    
    func tick() {
        self.serviceAdvertiser.startAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
        
    }
    
}

extension SessionManager : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: ((Bool, MCSession) -> Void)) {
        
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
    
}

extension SessionManager : MCNearbyServiceBrowserDelegate {
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, toSession: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

extension MCSessionState {
    
    func stringValue() -> String {
        switch(self) {
        case .NotConnected: return "NotConnected"
        case .Connecting: return "Connecting"
        case .Connected: return "Connected"
        default: return "Unknown"
        }
    }
    
}

extension SessionManager : MCSessionDelegate {
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.stringValue())")
        if state == .NotConnected {
            if outsidePersons.count > 0 {
                outsidePersons.removeLast()
            }
            self.delegate?.didDiconectDevice(self)
        }
        self.delegate?.connectedDevicesChanged(self, connectedDevices: session.connectedPeers.map({$0.displayName}))
    }
    
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data.length) bytes")
        if let person = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Person {
            if !outsidePersons.contains(person) {
                outsidePersons.append(person)}
            self.delegate?.didRecivePerson(self, person: person)
        }
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
}
