//#-hidden-code
import PlaygroundSupport

let proxy = PlaygroundPage.current.liveView as! PlaygroundRemoteLiveViewProxy

//#-end-hidden-code
/*:
# Sentiment Analysis
Another powerful feature we can use NLP is for detecting and analysing emotions.
If any of Nina's messages are detected to be negetive then I can help her take necessary actions and can even get a chocolate for her to cheer up!
 
* Important: This Playground Book is best experienced in Landscape with the LiveView alongside the code.
 

You can see the corresponding **emotion** that has been identified next to each text sent by Nina.

The model was trained with the [Large Movie Review Dataset](http://ai.stanford.edu/~amaas/data/sentiment/) on **CoreML** and imported into Swift Playgrounds 😁

The below message seems be negetive, tap *Run My Code* and see if our NLP system can detect it!
 
*/
 var message = /*#-editable-code*/"Oh no! I am hungry :("/*#-end-editable-code*/
/*:
 
Try changing the message to something possitive like (It's beautiful today!) and then tap *Run My Code*
Once you’re done, let’s [head over to next page](@next) to know a little about me!.
 
*/
//#-hidden-code
proxy.send(.string(message))
proxy.send(.boolean(true))

if message != "Oh no! I am hungry :(" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Awesome! Let's go to the next page, to know a little about me! 😁")
}
//#-end-hidden-code
