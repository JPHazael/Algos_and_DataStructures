//: Playground - noun: a place where people can play


// A more thorough explanation of retain cycles in closures is available here: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html

import UIKit

class HTMLElement{
    let name: String
    let text: String
    
    lazy var asHTML: () -> String = { [weak self] in // <- that's a capture list
        guard let this = self else{return ""} // use a guard statement to unwrap the optionals that are caused by using the capture list
        return "<\(this.name)>\(this.text)</\(this.name)>"
    }
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("HTML Element \(name) is being deinitialized.")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "sample text!")

paragraph?.asHTML()

paragraph = nil

