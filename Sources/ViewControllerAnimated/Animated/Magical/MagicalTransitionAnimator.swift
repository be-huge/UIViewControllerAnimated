import Foundation
import UIKit

class MagicalTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView;
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        else {
            return;
        }
        let snapshotImage = createImage(layer: fromVC.view.layer);
        let brokenGlassView = MagicalEffectView.init(frame: fromVC.view.bounds);

        fromVC.view.removeFromSuperview()
        containerView.window?.addSubview(toVC.view)
        containerView.window?.addSubview(brokenGlassView)
        brokenGlassView.setImageForAnimation(image: snapshotImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak brokenGlassView] in
            brokenGlassView?.removeFromSuperview()
            brokenGlassView?.destroy()
            transitionContext.completeTransition(true);
        }
    }
    
    func createImage(layer: CALayer) -> UIImage {
        let bitsPerComponent = 8
        let bytesPerPixel = 4
        let width:Int = Int(layer.bounds.size.width)
        let height:Int = Int(layer.bounds.size.height)
        let imageData = UnsafeMutableRawPointer.allocate(byteCount: Int(width * height * bytesPerPixel), alignment: 8)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let imageContext = CGContext.init(data: imageData, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: width * bytesPerPixel, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGImageByteOrderInfo.order32Big.rawValue )
        layer.render(in: imageContext!)
        
        let cgImage = imageContext?.makeImage()
        let image = UIImage.init(cgImage: cgImage!)
        return image
    }
    // func createImage(layer: CALayer) -> UIImage {
    //     let scale = UIScreen.main.scale

    //     let format = UIGraphicsImageRendererFormat()
    //     format.scale = scale
    //     format.opaque = false

    //     let size = layer.bounds.size

    //     let renderer = UIGraphicsImageRenderer(size: size, format: format)
    //     let image = renderer.image { ctx in
    //         layer.render(in: ctx.cgContext)
    //     }

    //     return image
    // }
}
