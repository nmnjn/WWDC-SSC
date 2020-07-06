//#-hidden-code
import PlaygroundSupport

let proxy = PlaygroundPage.current.liveView as! PlaygroundRemoteLiveViewProxy

//#-end-hidden-code
/*:
# Spam Detection
Nina is using the email system for the first time.
However she has started to receive some spam in her mails.
 
* Important: This Playground Book is best experienced in Landscape with the Live View alongside the code.
 
## Introducing Natural Language Processing
We will use **custom NLP models** that were trained on **CoreML** and imported into Swift Playgrounds 😁

It looks like Nina's mailbox has some unwanted messages. Let's set ``filterSpam`` variable below to true and try running the code. This will implement a model trained with the [Spam Collection Dataset](http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/) and hide the spam messages so they do not bother Nina.
 
*/
var filterSpam = /*#-editable-code*/false/*#-end-editable-code*/
/*:
 
Once you’ve changed the ``filterSpam`` variable above to true, tap *Run My Code* to see the changes!.
 
Let's see if this works on new mails, Write a mail below which may seem like spam, or a good one. Let's see if the power of NLP can understand it!
 
*/
 var mail = /*#-editable-code*/"Buy house fast for just 1$"/*#-end-editable-code*/
/*:
 
Tap *Run My Code* to see whether the model filters this mail as spam or not!
Once you’re done, let’s [head over to next page](@next) to check out some more power of NLP.
 
*/
//#-hidden-code
proxy.send(.string(mail))
proxy.send(.boolean(filterSpam))

if mail != "Buy house fast for just 1$" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Awesome! Let's go to the next page! 😁")
}
//#-end-hidden-code
