import UIKit

class ViewController: UIViewController, ScaledroneDelegate, ScaledroneRoomDelegate {

    let scaledrone = Scaledrone(channelID: "KtJ2qzn3CF3svSFe")

    override func viewDidLoad() {
        super.viewDidLoad()
        scaledrone.delegate = self
        scaledrone.connect()
    }

    func scaledroneDidConnect(scaledrone: Scaledrone, error: NSError?) {
        if (error != nil) {
            print(error!);
        }
        print("Connected to Scaledrone channel", scaledrone.clientID)
        let room = scaledrone.subscribe(roomName: "notifications")
        room.delegate = self
    }

    func scaledroneDidReceiveError(scaledrone: Scaledrone, error: NSError?) {
        print("Scaledrone error")
    }

    func scaledroneDidDisconnect(scaledrone: Scaledrone, error: NSError?) {
        print("Scaledrone disconnected")
    }

    func scaledroneRoomDidConnect(room: ScaledroneRoom, error: NSError?) {
        print("Scaledrone connected to room", room.name)
        scaledrone.publish(message: "Hello from Swift", room: room.name)

        room.publish(message: ["foo": "bar", "1": 1])
        room.publish(message: [1, 2, 3])
    }

    func scaledroneRoomDidReceiveMessage(room: ScaledroneRoom, message: Any) {
        if let message = message as? [String : Any] {
            print("Received a dictionary:", message)
        }
        if let message = message as? [Any] {
            print("Received an array:", message)
        }
        if let message = message as? String {
            print("Received a string:", message)
        }
    }
}
