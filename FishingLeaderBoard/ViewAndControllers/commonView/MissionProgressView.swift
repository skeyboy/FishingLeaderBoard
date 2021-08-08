//
//  MissionProgressView.swift
//  FishingLeaderBoard
//
//  Created by sk on 2020/3/4.
//  Copyright © 2020 yue. All rights reserved.
//


import UIKit
/**
         let myView = MyView.init(frame:         CGRect(x: 20, y: 200,
                                                        width: 200, height: 75)

             , progress: 0.75, total: 50)
         myView.backgroundColor = UIColor.white
 //        myView.frame = CGRect(x: 20, y: 200, width: 200, height: 75)
         view.addSubview(myView)

 */

/// 赛季任务进度表示
class MissionProgressView :UIView{
    let bgColor = UIColor.lightGray
    let forColor = UIColor.init(displayP3Red: 16/255.0, green: 74/255.0, blue: 186/255.0, alpha: 1)
    var progress = 0.93
    var total:Int32 = 150
    let startOffsetY = CGFloat(40+15)
    let rectHeight = CGFloat(20)
    var hoverX = CGFloat(0)
    var indicators:[String] = ["0","20","40","60","80","100","120","……"]
    @objc
    convenience init(frame :CGRect, progress:Double = 0, total:Int32 = 100) {
        self.init()
        self.frame = frame
        self.progress = progress
        self.total = total
    }
    @objc public func bindProgress(progress:Double = 0, total:Int32 = 100){
        self.progress = progress
        self.total = total
        self.backgroundColor = UIColor.white
        self.updateFocusIfNeeded()
    }
    override public func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
//        context?.setStrokeColor(bgColor.cgColor)
//        context?.setLineWidth(1)
        context?.setFillColor(forColor.cgColor)
       
        context?.move(to: CGPoint(x: 10, y: startOffsetY))
        context?.addLine(to: CGPoint(x: self.frame.width-20-rectHeight/2, y: startOffsetY))
        context?.addLine(to: CGPoint(x: self.frame.width-20-rectHeight/2, y: startOffsetY + rectHeight))
        context?.addLine(to: CGPoint(x: 10, y: startOffsetY+rectHeight))
        context?.addLine(to: CGPoint(x: 10, y: startOffsetY))
        hoverX = (self.frame.width-20)*CGFloat(progress*Double(self.total)/Double((self.indicators.count-1)*20))+10
        context?.move(to: CGPoint(x: hoverX, y: startOffsetY))
        context?.addLine(to: CGPoint(x: hoverX, y:startOffsetY-10))
        


        
//        context?.strokePath()
        
        let ctx1 = UIGraphicsGetCurrentContext()
        ctx1?.setFillColor(bgColor.cgColor)
        ctx1?.setLineWidth(0)
        ctx1?.fill(CGRect(x: 10+rectHeight/2, y: startOffsetY, width: (self.frame.width-20)-6-rectHeight, height: rectHeight))
        
        ctx1?.addArc(center: CGPoint(x:  self.frame.width-20-rectHeight/2, y: startOffsetY+rectHeight/2), radius: rectHeight/2, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi/2*3), clockwise: true)
        ctx1?.drawPath(using: CGPathDrawingMode.fillStroke)

        
        let ctx2 = UIGraphicsGetCurrentContext()
        ctx2?.setFillColor(forColor.cgColor)
        ctx2?.setLineWidth(0)
        context?.addArc(center: CGPoint(x: 10+rectHeight/2, y: startOffsetY+rectHeight/2), radius: rectHeight/2, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi/2*3), clockwise: false)
        context?.drawPath(using: CGPathDrawingMode.fillStroke)

        ctx2?.fill(CGRect(x: 10+rectHeight/2, y: startOffsetY, width:hoverX-10*2-rectHeight/2, height: rectHeight))
        //保证有半部分始终在右侧
        context?.addArc(center: CGPoint(x: hoverX-rectHeight/2>0 ? hoverX-rectHeight/2 : 10+rectHeight/2 , y: startOffsetY+rectHeight/2), radius: rectHeight/2, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi/2), clockwise: false)
               context?.drawPath(using: CGPathDrawingMode.fillStroke)
        context?.drawPath(using: CGPathDrawingMode.fillStroke)

        let items =  indicators
        var index = 0
        let step = self.frame.width / CGFloat(items.count)
        
        items.forEach { (txt) in
            let titleWidth = (txt as NSString).size(withAttributes: nil).width

            (txt as NSString).draw(at: CGPoint(x: 10 + CGFloat(step * CGFloat(index))-titleWidth/2, y: startOffsetY+rectHeight), withAttributes: nil)
            
            
            index = index+1
        }
      let title =  "您已完成\( Int(Double(total) * progress) )场比赛"
        let titleWidth = (title as NSString).size(withAttributes: nil).width
        let titleHeight = (title as NSString).size(withAttributes: nil).height
        
        var titleX = hoverX - titleWidth/2
        if titleX<0 {
            titleX = 0
        }
        if hoverX + titleWidth/2 > self.frame.width {
            titleX = self.frame.width-titleWidth
        }
        
//        if titleX + titleWidth >= self.frame.width {
//            titleX = self.frame.width-10-titleWidth
//        }
        
        (title as NSString).draw(at: CGPoint(x:titleX , y: startOffsetY-10-titleHeight), withAttributes: [NSAttributedString.Key.foregroundColor:forColor])
        
    }
}

