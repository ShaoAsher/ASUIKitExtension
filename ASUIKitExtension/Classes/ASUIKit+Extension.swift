//
//  ASUIKit+Extension.swift
//  ASUIKitExtension
//
//  Created by KerrDev on 31/12/2021.
//

import UIKit

// MARK: - === 视图扩展  ====
extension UIView{
    
    /// 添加圆角
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - masksToBounds: 是否切割
    public func AS_addCornerRadius(cornerRadius:CGFloat,masksToBounds:Bool){
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = masksToBounds
    }
    
    
    /// 切指定位置的圆角
    /// - Parameters:
    ///   - conrners: [] 位置数组
    ///   - radius: 圆角半径
    func AS_addCornerRadius(conrners: UIRectCorner , radius: CGFloat) {
        ///延迟调用
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            
            self.layoutIfNeeded()
            
            let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
            self.layer.masksToBounds = true
        }
    }
    
    
    /// 添加边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    public func AS_addBorder(borderWidth:CGFloat,borderColor:UIColor){
        
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.cgColor;
        
        
    }
    
    /// 添加渐变色
    /// - Parameters:
    ///   - colors: 颜色数组
    ///   - startPoint: 开始点
    ///   - endPoint: 结束点
    /// - Returns:
    func AS_addCAGradientLayerColor(colors:[CGColor],startPoint:CGPoint,endPoint:CGPoint) -> Void {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            
            self.superview?.layoutIfNeeded()
            let layer = CAGradientLayer()
            layer.colors = colors
            layer.startPoint = startPoint
            layer.endPoint = endPoint
            layer.frame = self.bounds
            self.layer.insertSublayer(layer, at: 0)
        }
        
        
    }
    
    /// 添加阴影
    /// - Parameters:
    ///   - shadowColor: 阴影颜色
    ///   - shadowOpacity: 阴影不透明度
    ///   - shadowRadius: 阴影半径
    ///   - shadowOffset: 阴影偏移量
    func AS_addShadow(shadowColor:UIColor,shadowOpacity:CGFloat,shadowRadius:CGFloat,shadowOffset:CGSize){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = Float(shadowOpacity)
    }

    
    /// 获取当前 某个视图在屏幕上的 xy
    /// - Returns: 坐标点
    func AS_PositionInScreen() -> CGPoint {
        /// 先判断是否有父视图，如果没有父视图，直接返回视图的位置就行
        if let superView = self.superview {
            /**
             判断父视图是否是UIScrollView或者继承自UIScrollView
             
             先使用视图在屏幕上的位置使用视图的位置与父视图的位置X与Y分别相加
             
             如果父视图不是UIScrollView并且不继承自UIScrollView，则直接返回结果
             
             如果父视图是UIScrollView或者继承自UIScrollView
             
             还需要分别减去UIScrollView的scrollViewOffset.x和scrollViewOffset.y，然后返回结果
             */
            if let scrollView = superView as? UIScrollView {
                let position = CGPoint.init(x: self.frame.origin.x, y: self.frame.origin.y)
                let superPosition = superView.AS_PositionInScreen()
                let scrollViewOffset = scrollView.contentOffset
                return CGPoint.init(x: superPosition.x + position.x - scrollViewOffset.x , y: superPosition.y + position.y - scrollViewOffset.y)
            } else {
                let superPosition = superView.AS_PositionInScreen()
                let position = self.frame.origin
                return CGPoint.init(x: superPosition.x + position.x, y: superPosition.y + position.y)
            }
        } else {
            return self.frame.origin
        }
        
    }
    
    
    /// 获取当前View所属的控制器
    /// - Returns: 控制器
    func AS_Nextresponsder()->UIViewController{
        
        var vc:UIResponder = self
        while (vc is UIViewController) != true {
            vc = vc.next ?? UIViewController()
        }
        return vc as? UIViewController ?? UIViewController()
    }
    
}
