////
////  ViewController.swift
////  Planets
////
////  Created by Diyorbek Xikmatullayev on 02/06/24.
////
//
//import SpriteKit
//import UIKit
//
//class GameScene: SKScene {
//    let R_c: CGFloat = 150        // Radiusning asosiy qiymati
//    let H: CGFloat = 400          // Umumiy balandlik
//    let dl: CGFloat = 10          // Uzunlik bo‘yicha qadam o‘lchami
//    let dh: CGFloat = 0.05        // Balandlik bo‘yicha qadam o‘lchami
//    let alfa: CGFloat = 45        // Y o‘qi bo‘yicha aylanish
//    let beta: CGFloat = 30        // X o‘qi bo‘yicha aylanish
//    let k: CGFloat = 1000         // Kamera masofasi
//    let t: CGFloat = 500          // Proyeksiya tekisligigacha masofa
//    let scale: CGFloat = 1.0      // Shaklni o'lchash koeffitsiyenti
//
//    override func didMove(to view: SKView) {
//        backgroundColor = .black
//        drawVariableRadiusShape()
//    }
//
//    func drawVariableRadiusShape() {
//        let centerX = frame.midX    // Ekran o'rtasi bo'yicha X koordinatasi
//        let centerY = frame.midY    // Ekran o'rtasi bo'yicha Y koordinatasi
//
//        var h: CGFloat = -1.0
//
//        while h <= 1.0 {
//            let R = max(1, R_c * (1 - 0.3 * sin(2 * CGFloat.pi * h)))  // Radiusni hisoblash
//            for l in stride(from: 0, through: 360, by: dl) {
//                var X = [CGFloat](repeating: 0, count: 4)
//                var Y = [CGFloat](repeating: 0, count: 4)
//
//                for i in 0..<4 {
//                    let angle = CGFloat(i == 1 || i == 2 ? l + dl : l)
//                    let z = H * (h + (i > 1 ? dh : 0))
//                    let x = R * sin(angle * .pi / 180)
//                    let y = R * cos(angle * .pi / 180)
//
//                    let dx = x * cos(alfa * .pi / 180) - y * sin(alfa * .pi / 180)
//                    let dy = x * sin(alfa * .pi / 180) * cos(beta * .pi / 180) +
//                             y * cos(alfa * .pi / 180) * cos(beta * .pi / 180) -
//                             z * sin(beta * .pi / 180)
//                    let dz = x * sin(alfa * .pi / 180) * sin(beta * .pi / 180) +
//                             y * cos(alfa * .pi / 180) * sin(beta * .pi / 180) +
//                             z * cos(beta * .pi / 180)
//
//                    // Shaklni ekranning markaziga joylash
//                    X[i] = (dx * (k - t) / max(1, k - dz)) * scale + centerX
//                    Y[i] = (dy * (k - t) / max(1, k - dz)) * scale + centerY
//                }
//
//                let path = CGMutablePath()
//                path.move(to: CGPoint(x: X[0], y: Y[0]))
//                for j in 1..<4 {
//                    path.addLine(to: CGPoint(x: X[j], y: Y[j]))
//                }
//                path.closeSubpath()
//
//                let shape = SKShapeNode(path: path)
//                shape.strokeColor = .white
//                shape.lineWidth = 1
//                addChild(shape)
//            }
//            h += dh
//        }
//    }
//}
//
//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let skView = SKView(frame: self.view.frame)
//        self.view = skView
//
//        let scene = GameScene(size: skView.bounds.size)
//        scene.scaleMode = .resizeFill
//
//        skView.presentScene(scene)
//        skView.ignoresSiblingOrder = true
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//}


//*********************************************************************

//import UIKit
//
//class DropletView: UIView {
//    let R: CGFloat = 200       // Radius of the shape
//    let dB: CGFloat = 10       // Latitude step size
//    let dL: CGFloat = 10       // Longitude step size
//    let alfa: CGFloat = 45     // Rotation around Y-axis
//    let beta: CGFloat = 30     // Rotation around X-axis
//    let k: CGFloat = 1000      // Camera distance
//    let t: CGFloat = 500       // Projection plane distance
//    
//    // Degree to Radian conversion
//    func toRadians(_ degree: CGFloat) -> CGFloat {
//        degree * .pi / 180.0
//    }
//    
//    override func draw(_ rect: CGRect) {
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        
//        context.setFillColor(UIColor.black.cgColor)
//        context.fill(rect)
//        context.setStrokeColor(UIColor.white.cgColor)
//        context.setLineWidth(1)
//        
//        for B in stride(from: -90, through: 90, by: dB) {
//            for L in stride(from: 0, through: 360, by: dL) {
//                var points: [CGPoint] = []
//                
//                for (bOffset, lOffset) in [(0, 0), (dB, 0), (dB, dL), (0, dL)] {
//                    let bRad = toRadians(B + CGFloat(bOffset))
//                    let lRad = toRadians(L + CGFloat(lOffset))
//                    
//                    let x = R * cos(bRad) * sin(lRad)
//                    let y = R * cos(bRad) * cos(lRad)
//                    let z = (B + CGFloat(bOffset) > 0) ? R * sin(bRad) + R * pow((B + CGFloat(bOffset)) / 90, 4) : R * sin(bRad)
//                    
//                    let dx = x * cos(toRadians(alfa)) - y * sin(toRadians(alfa))
//                    let dy = x * sin(toRadians(alfa)) * cos(toRadians(beta)) +
//                             y * cos(toRadians(alfa)) * cos(toRadians(beta)) - z * sin(toRadians(beta))
//                    let dz = x * sin(toRadians(alfa)) * sin(toRadians(beta)) +
//                             y * cos(toRadians(alfa)) * sin(toRadians(beta)) + z * cos(toRadians(beta))
//                    
//                    let screenX = dx * (k - t) / (k - dz) + rect.width / 2
//                    let screenY = dy * (k - t) / (k - dz) + rect.height / 2
//                    
//                    points.append(CGPoint(x: screenX, y: screenY))
//                }
//                
//                // Draw the wireframe grid
//                context.beginPath()
//                context.move(to: points[0])
//                for point in points[1...] {
//                    context.addLine(to: point)
//                }
//                context.closePath()
//                context.strokePath()
//            }
//        }
//    }
//}
//
//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let dropletView = DropletView(frame: view.bounds)
//        view.addSubview(dropletView)
//    }
//}

//**************************************

 
import UIKit

class BezierCurvesView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Background color
        UIColor.black.setFill()
        context.fill(rect)
        
        // Line color and width
        UIColor.white.setStroke()
        context.setLineWidth(1)
        
        // Drawing multiple Bézier curves to form shell-like shapes
        drawShellShape(context: context, rect: rect)
    }
    
    func drawShellShape(context: CGContext, rect: CGRect) {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let baseWidth: CGFloat = 50
        
        for i in 0..<5 {
            let offset = CGFloat(i) * 20
            let path = UIBezierPath()
            
            // Move to starting point
            path.move(to: CGPoint(x: centerX - baseWidth - offset, y: centerY + offset))
            
            // Control points and end point for Bézier curve
            let controlPoint1 = CGPoint(x: centerX, y: centerY - 150 - offset)
            let controlPoint2 = CGPoint(x: centerX + 150 + offset, y: centerY - 50 + offset)
            let endPoint = CGPoint(x: centerX + baseWidth + offset, y: centerY + offset)
            
            path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            // Add mirrored curve for symmetry
            let mirroredControlPoint1 = CGPoint(x: centerX - 150 - offset, y: centerY - 50 + offset)
            let mirroredControlPoint2 = CGPoint(x: centerX, y: centerY - 150 - offset)
            path.addCurve(to: CGPoint(x: centerX - baseWidth - offset, y: centerY + offset),
                          controlPoint1: mirroredControlPoint1,
                          controlPoint2: mirroredControlPoint2)
            
            path.close()
            path.stroke()
        }
    }
}

// ViewController to display the Bézier Curves
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let bezierView = BezierCurvesView(frame: view.bounds)
        bezierView.backgroundColor = .black
        view.addSubview(bezierView)
    }
}

