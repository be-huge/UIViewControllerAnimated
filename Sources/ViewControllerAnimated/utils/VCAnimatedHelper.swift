import Foundation
import UIKit

class VCAnimatedHelper {
  private init() {}

  static let shared = VCAnimatedHelper();

  let brokenGlassAnimator: MagicalTransitionAnimator = MagicalTransitionAnimator.init();
  private let blackVCList: [String] = [
    "_UIDICActivityViewController", // 分享面板
    // "UIActivityViewController", // 分享面板
    "UIAlertController",
  ];

  // 关闭vc的动画
  func dismissAnimator() -> UIViewControllerAnimatedTransitioning {
    return self.brokenGlassAnimator;
  }

  // push vc的动画
  // func presentAnimator() -> UIViewControllerAnimatedTransitioning {}

  // 动画VC黑名单
  func isIllegalVC(vc: UIViewController) -> Bool {
    for item in self.blackVCList {
      if vc.isKind(of: NSClassFromString(item)!) {
        return true;
      }
    }
    return false;
  }
}