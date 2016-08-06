import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    let colorService = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }
    
    @IBAction func redTapped(sender: AnyObject) {
        self.changeColor(UIColor.redColor())
        colorService.sendColor("red")
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
        self.changeColor(UIColor.yellowColor())
        colorService.sendColor("yellow")
    }
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
    
    @IBAction func retry(sender: UIButton) {
        colorService.serviceBrowser.stopBrowsingForPeers()
        colorService.serviceBrowser.startBrowsingForPeers()
        
    }
    
    
}

extension ViewController : SessionManagerDelegate {
    
    func connectedDevicesChanged(manager: SessionManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: SessionManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            switch colorString {
            case "red":
                self.changeColor(UIColor.redColor())
            case "yellow":
                self.changeColor(UIColor.yellowColor())
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}