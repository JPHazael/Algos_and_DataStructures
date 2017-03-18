//: Playground - noun: a place where people can play

import UIKit


class Circle: UIView{
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: .zero)
        
        
        // Draw the circle with a loop
        
        let radius: Double = 100
        path.move(to: CGPoint(x: center.x + CGFloat(radius), y: center.y))

        
        for i in stride(from: 0, to: 361.0, by: 0.5){
            
            let center = CGPoint(x: rect.width / 2 , y: rect.height / 2)
            
            
            let radians = i * Double.pi / 180.0
            
            let x = Double(center.x) + radius * cos(radians)
            let y =  Double(center.y) + radius * sin(radians)
            
            path.addLine(to: CGPoint(x: x, y: y))
            
            
            
        }
        path.lineWidth = 5
        UIColor.white.setStroke()

        path.stroke()
    }
    
}

let view = Circle(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

view.backgroundColor = .blue
