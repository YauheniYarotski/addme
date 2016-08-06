import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    let sessionManager = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionManager.delegate = self
    }
    
    @IBAction func sendTaped(sender: UIButton) {
        sessionManager.sendMyContact()
    }
    
    @IBAction func retry(sender: UIButton) {
        sessionManager.serviceBrowser.stopBrowsingForPeers()
        sessionManager.serviceBrowser.startBrowsingForPeers()
    }
    
}

extension ViewController : SessionManagerDelegate {
    
    func connectedDevicesChanged(manager: SessionManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
            if connectedDevices.count > 0 {
                self.sessionManager.sendMyContact()
            }
        }
    }
    
    func didRecivePerson(manager: SessionManager, person: Person) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            print(person.name, person.contacts)
            let url = NSURL(string: person.contacts["fb"]!)!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
}