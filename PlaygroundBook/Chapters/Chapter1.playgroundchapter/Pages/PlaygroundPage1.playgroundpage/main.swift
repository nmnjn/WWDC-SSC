//#-hidden-code
import PlaygroundSupport

let proxy = PlaygroundPage.current.liveView as! PlaygroundRemoteLiveViewProxy

var message = ""
var numberOfHackers = 3
var encryption = false

//#-end-hidden-code
/*:
 
 
## Hey there, Meet Nina ✌🏻!

Nina is my little sister. She recently got her first iPad and is connecting to the internet for the first time.

I want to use the power of technology to make this environment safe and secure for her !
 
I tried explaining the concept of **Encryption** to her, but she didn't seem to be interested at all 😕. So I built a simple game to make it interesting and also fun 😁!
 
 
* Important: This Page is best experienced in Landscape with the LiveView in fullscreen.
 
### Stage 1
Enter a message you want to send to Jake!
*/
message = /*#-editable-code*/""/*#-end-editable-code*/
/*:
 
Once you’ve entered the ``message`` you want to send,
tap *Run My Code* to check if you can successfully deliver it.

 

**Be careful of the hackers 😈 who want to hack the message. Make sure you do not touch them!**
**Drag the document📝 from Nina to Jake without coming in contact with the hackers.**
 

### Stage 2
That was fairly easy right? In the real world there are many more notorius hackers. Try changing the number of hackers! Make them 10 or 15.
*/
numberOfHackers = /*#-editable-code*/3/*#-end-editable-code*/
/*:
 
Once you’ve changed the ``numberOfHackers``, tap *Run My Code* to see if it is still possible for you to deliver the message without getting hacked!.

### Stage 3
 
#### Did that get difficult?
We now introduce the **power of encryption**! When you enable encryption, 2 keys are generated for all users.
One is a public key which is visible to all the users on the internet. This key can be used to lock any data.
The second is a private key which is only accesible to the user who has generated it.
Only this key can be used to unlock the data.
 
*/
encryption = /*#-editable-code*/false/*#-end-editable-code*/
/*:
 
Once you’ve changed the ``encryption`` to true, tap *Run My Code* to see if you can encrypt the message and deliver it without worries!.
 
* Experiment: Try bringing Jake's public key to the document! Once the document is encrypted the hackers will bounce right off it! 😃

 Once you’re done, let’s [head over to next page](@next) to check out how we can use some cool technology to make the internet safer!
 */
//#-hidden-code

proxy.send(.string(message))
proxy.send(.boolean(encryption))
proxy.send(.integer(numberOfHackers))

//
//if greeting != "Como você está, Fred?" {
//    PlaygroundPage.current.assessmentStatus = .pass(message: "Awesome! Once you're ready, ready over to the next page 😁")
//}

//#-end-hidden-code
