/*
Supplemental material (code examples, exercises, etc.) is available for download at https://github.com/vandadnp/iOS-10-Swift-Programming-Cookbook.
*/


/*
Chapter 1. iMessage Stickers and Apps
*/

//  Sticker Pack Application

/*
Chapter 2. SiriKit

Follow these steps, the details of which can be found in this recipe’s Discussion:

1. Create your app, if you don’t already have one.
2. Enable Siri capabilities in your target’s preferences in Xcode.
3. Add an Intents extension to your app as a new target.
4. Define your intents in the extension’s info.plist file.
5. In your app’s info.plist file, define the NSSiriUsageDescription key, along with a message explaining why you are intending to use Siri in your application. This message will be shown to the user when you attempt to ask for permission to integrate into Siri.
6. Import the Intents framework into your app.
7. Call the requestSiriAuthorization(_:) class method of the INPreferences class and ask the user for authorization to use Siri.
8. If the status is authorized, then you might need to wait a few minutes before Siri indexes your app’s intents and understands that your app is going to need to interact with Siri.

*/

//  Intents Extension

/*
Chapter 3. Measurements and Units
*/

let meters = Measurement(value: 5, unit: UnitLength.meters) // 5.0 m
let kilometers = Measurement(value: 1, unit: UnitLength.kilometers) // 1.0 km

//!!
PlaygroundPage.current.needsIndefiniteExecution = true

//  Second
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension Double{
  var seconds: Measurement<UnitDuration>{
    return Measurement(value: self, unit: UnitDuration.seconds)
  }
}

var remainingTime = Measurement(value: 10, unit: UnitDuration.seconds)
Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
  let minutesRemaining = remainingTime.converted(to: UnitDuration.minutes)
  print("\(minutesRemaining.value) minutes remaining before the timer stops")
  remainingTime = remainingTime - (1.0).seconds
  if remainingTime.value <= 0.0{
    timer.invalidate()
  }
}


/*
Chapter 4. Core Data
*/

let context = persistentContainer.viewContext
let personFetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
personFetchRequest.fetchLimit = 1
personFetchRequest.relationshipKeyPathsForPrefetching = ["cars"]
let persons = try context.fetch(personFetchRequest)
guard let person = persons.first,
  persons.count == personFetchRequest.fetchLimit else {
  throw ReadDataExceptions.moreThanOnePersonCameBack
}
//enum ReadDataExceptions : Error{
//  case moreThanOnePersonCameBack
//}

func personsWith(firstNameFirstCharacter char: Character) throws -> [Person]?{

 let context = persistentContainer.viewContext
 let request: NSFetchRequest<Person> = Person.fetchRequest()

  request.predicate = NSPredicate(format: "firstName LIKE[c] %@",
                                argumentArray: ["\(char)*"])

  return try context.fetch(request)

}

/*
Chapter 5. Swift 3.0, Xcode 8, and Interface Builder
*/

//  Defer

func imageForString(_ str: String, size: CGSize) throws -> UIImage{
  
  defer{
    UIGraphicsEndImageContext()
  }
  
  UIGraphicsBeginImageContextWithOptions(size, true, 0)
  
  if str.characters.count == 0{
    throw Errors.emptyString
  }
  
  // draw the string here...
  
  return UIGraphicsGetImageFromCurrentImageContext()!
  
}

if #available(iOS 8.1, *){

} else {

}


//  Categorizing and Downloading Assets to Get Smaller Binaries

/*

Problem
You have many assets in your app for various circumstances, and want to save storage space and network usage on each user’s device by shipping the app without the optional assets. Instead, you would want to dynamically download them and use them whenever needed.

Solution
Use Xcode to tag your assets and then use the NSBundleResourceRequest class to download them.

*/

// Assets Inspector Bottom 'On Demand Resource Tags'

/*
Exporting Device-Specific Binaries

Problem
You want to extract your app’s binary for a specific device architecture to determine how big your binary will be on that device when the user downloads your app.

Bitcode is Apple’s way of specifying how the binary that you submit to the App Store will be downloaded on target devices. For instance, if you have an asset catalog with some images for iPad and iPhone and a second set of images for iPhone 6 and 6+ specifically, users on iPhone 5 should not get the second set of assets. This is the default functionality in Xcode, so you don’t have to do anything special to enable it. If you are working on an old project, you can enable bitcode from Build Settings in Xcode.

Apple will detect the host device that is downloading your app from the store and will serve the right binary to that device. It’s not necessary to separate your binaries when submitting to Apple—simply submit a big, fat, juicy binary and Apple will take care of the rest.
*/
  
//  Refator to Storyboards

/*

Optimizing Your Swift Code

Use the following techniques:

- Enable whole module optimization on your code.
- Use value types (such as structs) instead of reference types where possible.
- Consider using final for classes, methods, and variables that aren’t going to be overridden.
- Use the CFAbsoluteTimeGetCurrent function to profile your app inside your code.
- Always use Instruments to profile your code and find bottlenecks.

var x = CFAbsoluteTimeGetCurrent()
x = (CFAbsoluteTimeGetCurrent() - x) * 1000.0
print("Took \(x) milliseconds")

/*
Showing the Header View of Your Swift Classes
Assistant Editor -> Generated Interface / Counterparts
*/

*/

/*
OptionSet protocol

*/

  struct IphoneModels : OptionSet, CustomDebugStringConvertible{
    
    let rawValue: Int
    init(rawValue: Int){
      self.rawValue = rawValue
    }
    
    static let Six = IphoneModels(rawValue: 0)
    static let SixPlus = IphoneModels(rawValue: 1)
    static let Five = IphoneModels(rawValue: 2)
    static let FiveS = IphoneModels(rawValue: 3)
    
    var debugDescription: String{
      switch self{
      case IphoneModels.Six:
        return "iPhone 6"
      case IphoneModels.SixPlus:
        return "iPhone 6+"
      case IphoneModels.Five:
        return "iPhone 5"
      case IphoneModels.FiveS:
        return "iPhone 5s"
      default:
        return "Unknown iPhone"
      }
    }
    
  }
  
  func example1(){
    
    let myIphones: [IphoneModels] = [.Six, .SixPlus]
    
    if myIphones.contains(.FiveS){
      print("You own an iPhone 5s")
    } else {
      print("You don't seem to have an iPhone 5s but you have these:")
      for i in myIphones{
        print(i)
      }
    }
    
  }

/*

Conditionally Extending a Type

*/

//  Only Int
extension Sequence where Iterator.Element == Int{
  public func canFind(_ value: Iterator.Element) -> Bool{
    return contains(value)
  }
}

//  double or floating point
extension Sequence where Iterator.Element : FloatingPoint{
  // write your code here
  func doSomething(){
    // TODO: code this
  }
}

/*
Building Equality Functionality into your own types
*/

protocol Named{
  var name: String {get}
}

func ==(lhs : Named, rhs: Named) -> Bool{
  return lhs.name == rhs.name
}

/*
  Looping conditionally through a collection
*/

let dic = [
  "name" : "Foo",
  "lastName" : "Bar",
  "age" : 30,
  "sex" : 1,
] as [String : Any]

// or where v is Int && v as! Int > 10
for (k, v) in dic where v is Int{
  print("The key \(k) contains an integer value of \(v)")
}


let nums = 0..<1000
let divisibleBy8 = {$0 % 8 == 0}
for n in nums where divisibleBy8(n){
  print("\(n) is divisible by 8")
}

/*
Chapter 6. The User Interface
*/

UIViewPropertyAnimator

animator.startAnimation()

/*

Attaching Live Views to Playgrounds

*/

import UIKit
import PlaygroundSupport

extension Double{
  var toSize: CGSize{
    return .init(width: self, height: self)
  }
}

extension CGSize{
  var toRectWithZeroOrigin: CGRect{
    return CGRect(origin: .zero, size: self)
  }
}

let view = UIView(frame: 300.toSize.toRectWithZeroOrigin)
view.backgroundColor = .blue
PlaygroundPage.current.liveView = view

/*
Allowing Users to Enter Text in Response to Local and Remote Notifications
To solve this problem, set the new behavior property of the UIUserNotificationAction class to .TextInput (with a leading period).
*/

func registerForNotifications(){

 let enterInfo = UIMutableUserNotificationAction()
 enterInfo.identifier = "enter"
 enterInfo.title = "Enter your name"
 enterInfo.behavior = .textInput // this is the key to this example
 enterInfo.activationMode = .foreground

 let cancel = UIMutableUserNotificationAction()
 cancel.identifier = "cancel"
 cancel.title = "Cancel"

 let category = UIMutableUserNotificationCategory()
 category.identifier = "texted"
 category.setActions([enterInfo, cancel], for: .default)

 let settings = UIUserNotificationSettings(
   types: .alert, categories: [category])

 UIApplication.shared.registerUserNotificationSettings(settings)

}

/*

 Dealing with Stacked Views in Code
*/

override func viewDidLoad() {
  super.viewDidLoad()

  rightStack = UIStackView(arrangedSubviews:
    [lblWithIndex(1), lblWithIndex(2), lblWithIndex(3), newButton()])

  view.addSubview(rightStack)

  rightStack.translatesAutoresizingMaskIntoConstraints = false

  rightStack.axis = .vertical
  rightStack.distribution = .equalSpacing
  rightStack.spacing = 5

  rightStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                       constant: -20).isActive = true
  rightStack.topAnchor.constraint(
    equalTo: topLayoutGuide.bottomAnchor).isActive = true

}

/*
Showing Web Content in Safari View Controller
*/

import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate{
  
  @IBOutlet var textField: UITextField!
  
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func openInSafari() {
    
    guard let t = textField.text, t.characters.count > 0,
      let u = URL(string: t)  else{
        //the url is missing, you can further code this method if you want
        return
    }
    
    let controller = SFSafariViewController(url: u,
                                            entersReaderIfAvailable: true)
    controller.delegate = self
    present(controller, animated: true, completion: nil)
    
  }
  
}

/*
Laying Out Text-Based Content on Your Views
Use the readableContentGuide property of UIView.
*/


let label = UILabel()
label.translatesAutoresizingMaskIntoConstraints = false
label.backgroundColor = UIColor.green
label.text = "Hello, World"
label.sizeToFit()
view.addSubview(label)

label.leadingAnchor.constraint(
  equalTo: view.readableContentGuide.leadingAnchor).isActive = true

label.topAnchor.constraint(
  equalTo: view.readableContentGuide.topAnchor).isActive = true

label.trailingAnchor.constraint(
  equalTo: view.readableContentGuide.trailingAnchor).isActive = true

label.bottomAnchor.constraint(
  equalTo: view.readableContentGuide.bottomAnchor).isActive = true

}

/*
Improving Touch Rates for Smoother UI Interactions

Problem
You want to be able to improve the interaction of the user with your app by decreasing the interval required between touch events.

Solution
Use the coalescedTouchesForTouch(_:) and the predictedTouchesForTouch(_:) methods of the UIEvent class. The former method allows you to receive coalesced touches inside an event, while the latter allows you to receive predicted touch events based on iOS’s internal algorithms.

Discussion
On selected devices such as iPad Air 2, the display refresh rate is 60Hz like other iOS devices, but the touch scan rate is 120Hz. This means that iOS on iPad Air 2 scans the screen for updated touch events twice as fast as the display’s refresh rate. These events obviously cannot be delivered to your app faster than the display refresh rate (60 times per second), so they are coalesced. At every touch event, you can ask for these coalesced touches and base your app’s reactions on them.
*/
class MyView : UIView{
  
  var points = [CGPoint]()
  
  func drawForFirstTouchInSet(_ s: Set<UITouch>, event: UIEvent?){
    
    guard let touch = s.first, let event = event,
      let allTouches = event.coalescedTouches(for: touch),
      allTouches.count > 0 else{
        return
    }
    
    points += allTouches.map{$0.location(in: self)}
    
    setNeedsDisplay()
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    
    points.removeAll()
    drawForFirstTouchInSet(touches, event: event)
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>,
                                 with event: UIEvent?) {
    
    points.removeAll()
    setNeedsDisplay(bounds)
    
  }
  
  override func touchesMoved(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    
    drawForFirstTouchInSet(touches, event: event)
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    
    guard let touch = touches.first, let event = event,
      let predictedTouches = event.predictedTouches(for: touch),
      predictedTouches.count > 0 else{
        return
    }
    
    points += predictedTouches.map{$0.location(in: self)}
    setNeedsDisplay()
    
  }
  
  override func draw(_ rect: CGRect) {
    
    let con = UIGraphicsGetCurrentContext()
    
    //set background color
    con?.setFillColor(UIColor.black.cgColor)
    con?.fill(rect)
    
    con?.setFillColor(UIColor.red.cgColor)
    con?.setStrokeColor(UIColor.red.cgColor)
    
    for point in points{
      
      con?.move(to: point)
      
      if let last = points.last, point != last{
        let next = points[points.index(of: point)! + 1]
        con?.addLine(to: next)
      }
      
    }
    
    con?.strokePath()
    
  }
  
}

/*
Associating Keyboard Shortcuts with View Controllers
Problem
You want to allow your application to respond to complex key combinations that a user can press on an external keyboard, to give the user more ways to interact with your app.

Solution
Construct an instance of the UIKeyCommand class and add it to your view controllers using the addKeyCommand(_:) method. You can remove key commands with the removeKeyCommand(_:) method.

*/

override func viewDidLoad() {
  super.viewDidLoad()

  let command = UIKeyCommand(input: "N",
    modifierFlags: .command + .alternate + .control,
    action: #selector(ViewController.handleCommand(_:)))

  addKeyCommand(command)

}

/*
Recording the Screen and Sharing the Video

ReplayKit

Throughout this whole process, your app doesn’t get direct access to the recorded content. This protects the user’s privacy.

*/


import ReplayKit
class ViewController: UIViewController, RPScreenRecorderDelegate,
RPPreviewViewControllerDelegate {

  func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
    dismiss(animated: true, completion: nil)
  }

  let recorder = RPScreenRecorder.shared()
  
  @IBAction func record() {
    
    startBtn.isEnabled = true
    stopBtn.isEnabled = false
    
    guard recorder.isAvailable else{
      print("Cannot record the screen")
      return
    }
    
    recorder.delegate = self
    
    recorder.startRecording {[weak self]err in
      
      guard let strongSelf = self else {return}
      
      if let error = err as? NSError{
        if error.code == RPRecordingErrorCode.userDeclined.rawValue{
          print("User declined app recording")
        }
        else if error.code == RPRecordingErrorCode.insufficientStorage.rawValue{
          print("Not enough storage to start recording")
        }
        else {
          print("Error happened = \(err!)")
        }
        return
      } else {
        print("Successfully started recording")
        strongSelf.startBtn.isEnabled = false
        strongSelf.stopBtn.isEnabled = true
      }
      
    }
    
    
    
  }
  
  @IBAction func stop() {
    
    recorder.stopRecording{controller, err in
      
      guard let previewController = controller, err == nil else {
        self.startBtn.isEnabled = true
        self.stopBtn.isEnabled = false
        print("Failed to stop recording")
        return
      }
      
      previewController.previewControllerDelegate = self
      
      self.present(previewController, animated: true,
                   completion: nil)
      
    }
    
  }
}

/*
Chapter 7. Apple Watch
*/

/*
Downloading Files onto the Apple Watch
You want to be able to download files from your watch app directly without needing to communicate your intentions to the paired iOS device.
*/

// Always consider whether or not you need the file immediately. If you need the file and the size is quite manageable, download it on the watch itself. If the file is big, try to download it on the companion app on the iOS device first and then send the file over to the watch, which itself takes some time.

/*
Noticing Changes in Pairing State Between the iOS and Watch Apps
WatchConnectivity
*/

guard WCSession.isSupported() else{
  status = "Sessions are not supported"
  return
}

let session = WCSession.default()
session.delegate = self
session.activate()
isReachable = session.isReachable


/*
Transferring Small Pieces of Data to and from the Watch
You want to transfer some plist-serializable content between your apps (iOS and watchOS).

- Use what you learned in Recipe 7.2 to find out whether both devices are reachable.
- On the sending app, use the updateApplicationContext(_:) method of your session to send the content over to the other app.
- On the receiving app, wait for the session(_:didReceiveApplicationContext:) delegate method of WCSessionDelegate, where you will be given access to the transmitted content.

//  It’s important to note that the content that you transmit must be of type [String : AnyObject].

*/
//  iPhone
var people: [String : AnyObject]?
@IBAction func send() {
  
  guard let people = self.people else{
    status = "People object is not available. Redownload?"
    return
  }
  
  let session = WCSession.default()
  
  do{
    try session.updateApplicationContext(people)
    status = "Successfully updated the app context"
  } catch {
    status = "Failed to update the app context"
  }
  
  
}

//  Watch

/*
Transferring Dictionaries in Queues to and from the Watch

Call the transferUserInfo(_:) method on your WCSession on the sending part. On the receiving part, implement the session(_:didReceiveUserInfo:) method of the WCSessionDelegate protocol.

*/

@IBAction func send() {
  
  guard let infoPlist = Bundle.main.infoDictionary else{
    status = "Could not get the info.plist"
    return
  }
  
  let key = kCFBundleIdentifierKey as String
  
  let plist = [
    key : infoPlist[key] as! String
  ]
  
  let transfer = WCSession.default().transferUserInfo(plist)
  status = transfer.isTransferring ? "Sent" : "Could not send yet"
  
}

/*
Transferring Files to and from the Watch
You want to transfer a file between your iOS app and the watch app. The technique works in both directions.

Solutions:
- Use the transferFile(_:metadata:) method of your WCSession object on the sending device.
- Then implement the WCSessionDelegate protocol on the sender and wait for the session(_:didFinishFileTransfer:error:) delegate method to be called. If the optional error parameter is nil, it indicates that the file is transferred successfully.
- On the receiving part, become the delegate of WCSession and then wait for the session(_:didReceiveFile:) delegate method to be called.
- The incoming file on the receiving side is of type WCSessionFile and has properties such as fileURL and metadata. The metadata is the same metadata of type [String : AnyObject] that the sender sent with the transferFile(_:metadata:) method.
*/

/*

7.6 Communicating Interactively Between iOS and watchOS
Problem
You want to interactively send messages from iOS to watchOS (or vice versa) and receive a reply immediately.

Solution
On the sender side, use the sendMessage(_:replyHandler:errorHandler:) method of WCSession. On the receiving side, implement the session(_:didReceiveMessage:replyHandler:) method to handle the incoming message if your sender expected a reply, or implement session(_:didReceiveMessage:) if no reply was expected from you. Messages and replies are of type [String : AnyObject].


*/



/*
Setting Up Apple Watch for Custom Complications
You want to create a barebones watch project with support for complications and you would like to see a complication on the screen.
*/

/*
Playing Local and Remote Audio and Video in Your Watch App
Use the presentMediaPlayerControllerWithURL(_:options:completion:) instance method of your interface controller (WKInterfaceController). Close the media player with the dismissMediaPlayerController() method.
*/

@IBAction func play() {

guard let url = URL(string: "http://localhost:8888/video.mp4") else{
  status = "Could not create url"
  return
}

let gravity = WKVideoGravity.resizeAspectFill.rawValue

let options = [
  WKMediaPlayerControllerOptionsAutoplayKey : NSNumber(value: true),
  WKMediaPlayerControllerOptionsStartTimeKey : 4.0 as TimeInterval,
  WKMediaPlayerControllerOptionsVideoGravityKey : gravity,
  WKMediaPlayerControllerOptionsLoopsKey : NSNumber(value: true),
] as [AnyHashable : Any]

presentMediaPlayerController(with: url, options: options) {
  didPlayToEnd, endTime, error in
  
  self.dismissMediaPlayerController()
  
  guard error == nil else{
    self.status = "Error occurred \(error)"
    return
  }
  
  if didPlayToEnd{
    self.status = "Played to end of the file"
  } else {
    self.status = "Did not play to end of file. End time = \(endTime)"
  }
  
}

}

/*
Chapter 8. Contacts
*/

/*
Creating Contacts
*/

import Foundation
import Contacts

public final class ContactAuthorizer{
  
  public class func authorizeContacts(completionHandler
    : @escaping (_ succeeded: Bool) -> Void){
    
    switch CNContactStore.authorizationStatus(for: .contacts){
    case .authorized:
      completionHandler(true)
    case .notDetermined:
      CNContactStore().requestAccess(for: .contacts){succeeded, err in
        completionHandler(err == nil && succeeded)
      }
    default:
      completionHandler(false)
    }
    
  }
  
}

let fooBar = CNMutableContact()
...
//finally save
let request = CNSaveRequest()
request.add(fooBar, toContainerWithIdentifier: nil)
do{
  try store.execute(request)
  print("Successfully stored the contact")
} catch let err{
  print("Failed to save the contact. \(err)")
}

/*
Searching for Contacts
*/

/*
Chapter 9. Extensions
*/

/*
Creating Safari Content Blockers

*/
[
  {
    "action": {
      "type": "block"
      },
      "trigger": {
        "url-filter": ".*",
        "resource-type" : ["image"],
        "if-domain" : ["edition.cnn.com"]
      }
   }
]

[
  {
    "action": {
      "type": "block" | "block-cookies" | "css-display-none",
      "selector" : This is a CSS selector that the action will be applied to
    },
    "trigger": {
      "url-filter": "this is a filter that will be applied on the WHOLE url",
      "url-filter-is-case-sensitive" : same as url-filter but case sensitive,
      "resource-type" : ["image" | "style-sheet" | "script" | "font" | etc],
      "if-domain" : [an array of actual domain names to apply filter on],
      "unless-domain" : [an array of domain names to exclude from filter],
      "load-type" : "first-party" | "third-party"
    }
  }
]

{
  "action": {
    "type": "css-display-none",
    "selector" : "a"
  },
  "trigger": {
    "url-filter": ".*",
    "if-domain" : ["macrumors.com"]
  }
}

{
  "action": {
    "type": "css-display-none",
    "selector" : "a[id='logo']"
  },
  "trigger": {
    "url-filter": ".*",
    "if-domain" : ["macrumors.com"]
  }
}


/*
Shared Links
*/
class RequestHandler: NSObject, NSExtensionRequestHandling {
  
  func beginRequest(with context: NSExtensionContext) {
    let extensionItem = NSExtensionItem()
    
    extensionItem.userInfo = [
      "uniqueIdentifier": "uniqueIdentifierForSampleItem",
      "urlString": "http://reddit.com/r/askreddit",
      "date": Date()
    ]
    
    extensionItem.attributedTitle = NSAttributedString(string: "Reddit")
    
    extensionItem.attributedContentText = NSAttributedString(
      string: "AskReddit, one of the best subreddits there is")
    
    guard let img = Bundle.main.url(forResource: "ExtIcon",
      withExtension: "png") else {
        context.completeRequest(returningItems: nil, completionHandler: nil)
        return
    }
    
    extensionItem.attachments = [NSItemProvider(contentsOf: img)!]
    
    context.completeRequest(returningItems: [extensionItem],
                            completionHandler: nil)
  }
  
}

/*
Chapter 10. Web and Search
*/

//  Delete items
let identifiers = [
  "com.yourcompany.etc1",
  "com.yourcompany.etc2",
  "com.yourcompany.etc3"
]

let i = CSSearchableIndex(name: Bundle.main.bundleIdentifier!)
i.fetchLastClientState {clientState, err in
  guard err == nil else{
    print("Could not fetch last client state")
    return
  }
  
  let state: Data
  if let s = clientState{
    state = s
  } else {
    state = Data()
  }
  
  i.beginBatch()
  
  i.deleteSearchableItems(withIdentifiers: identifiers) {err in
    if let e = err{
      print("Error happened \(e)")
    } else {
      print("Successfully deleted the given identifiers")
    }
  }
  i.endBatch(withClientState: state, completionHandler: {err in
    guard err == nil else{
      print("Error happened in ending batch updates = \(err!)")
      return
    }
    print("Successfully batch updated the index")
  })
  
}

/*
Handling Low Power Mode and Providing Alternatives

To determine if the device is in low power mode, read the value of the lowPowerModeEnabled property of your process (of type NSProcessInfo), and listen to NSProcessInfoPowerStateDidChangeNotification notifications to find out when this state changes.

Discussion
Low power mode is a feature that Apple has placed inside iOS so that users can preserve battery whenever they wish to. For instance, if you have 10% battery while some background apps are running, you can save power by:

- Disabling background apps
- Reducing network activity
- Disabling automatic mail pulls
- Disabling animated backgrounds
- Disabling visual effects
*/

/*
Chapter 12. Maps and Location
*/

/*
Requesting the User’s Location in the Background
Solution
Set the allowsBackgroundLocationUpdates property of your location manager to true and ask for location updates using the requestAlwaysAuthorization() function.
*/

lazy var locationManager: CLLocationManager = {
  let m = CLLocationManager()
  m.delegate = self
  m.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  m.allowsBackgroundLocationUpdates = true
  return m
}()

/*
Chapter 13. UI Testing
*/

/*
Chapter 14. Core Motion
*/

/*
Querying Pace and Cadence Information
- Find out whether cadence and pace are available.
- Call the startUpdates(from:withHandler:) function of CMPedometer.
- In your handler block, read the currentPace and currentCadence properties of the incoming optional CMPedometerData object.
*/

guard CMPedometer.isCadenceAvailable() &&
  CMPedometer.isPaceAvailable() else{
    print("Pace and cadence data are not available")
    return
}

let oneWeekAgo = Date(timeIntervalSinceNow: -(7 * 24 * 60 * 60))
pedometer.startUpdates(from: oneWeekAgo) {data, error in
  
  guard let pData = data, error == nil else{
    return
  }
  
  if let pace = pData.currentPace{
    print("Pace = \(pace)")
  }
  
  if let cadence = pData.currentCadence{
    print("Cadence = \(cadence)")
  }
  
}

// remember to stop the pedometer updates with stopPedometerUpdates()
// at some point

/*
Chapter 15. Security
Application Transport Security, or ATS
*/

NSAppTransportSecurity
NSExceptionDomains

//disable ATS completely
<plist version="1.0">
<dict>
  <key>NSExceptionDomains</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
  </dict>
</dict>
</plist>

// have ATS enabled but not for mydomain.com

<plist version="1.0">
<dict>
<key>NSExceptionDomains</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <false/>
  <key>mydomain.com</key>
  <dict>
    <key>NSExceptionAllowsInsecureHTTPLoads</key>
    <true/>
    <key>NSIncludesSubdomains</key>
    <true/>
    <key>NSRequiresCertificateTransparency</key>
    <true/>
  </dict>
</dict>
</dict>
</plist>

/*
Chapter 16. Multimedia
*/

/*
Reading Out Text with the Default Siri Alex Voice
Problem
You want to use the default Siri Alex voice on a device to speak some text.

Solution
Instantiate AVSpeechSynthesisVoice with the identifier initializer and pass the value of AVSpeechSynthesisVoiceIdentifierAlex to it.
*/
@IBAction func read(_ sender: AnyObject) {

guard let voice = AVSpeechSynthesisVoice(identifier:
  AVSpeechSynthesisVoiceIdentifierAlex) else{
    print("Alex is not available")
    return
}

print("id = \(voice.identifier)")
print("quality = \(voice.quality)")
print("name = \(voice.name)")

let toSay = AVSpeechUtterance(string: textView.text)
toSay.voice = voice

let alex = AVSpeechSynthesizer()
alex.delegate = self
alex.speak(toSay)

}

/*
Chapter 17. UI Dynamics
*/

lazy var animator: UIDynamicAnimator = {
  let animator = UIDynamicAnimator(referenceView: self.view)
  animator.isDebugEnabled = true
  return animator
  }()

@import UIKit;

//  Dynamic-Bridging-Header.h
#if DEBUG

@interface UIDynamicAnimator (DebuggingOnly)
@property (nonatomic, getter=isDebugEnabled) BOOL debugEnabled;
@end

#endif

//  Linear Field
lazy var gravity: UIFieldBehavior = {
  let vector = CGVector(dx: 0.4, dy: 1.0)
  let gravity =
  UIFieldBehavior.linearGravityField(direction: vector)
  gravity.addItem(self.orangeView)
  return gravity
  }()

//  Center Radial Gravity Field
lazy var centerGravity: UIFieldBehavior = {
  let centerGravity =
  UIFieldBehavior.radialGravityField(position: self.view.center)
  centerGravity.addItem(self.orangeView)
  centerGravity.region = UIRegion(radius: 200)
  centerGravity.strength = -1 // repel items
  return centerGravity
  }()

//  Collections
@IBOutlet var views: [UIView]!









