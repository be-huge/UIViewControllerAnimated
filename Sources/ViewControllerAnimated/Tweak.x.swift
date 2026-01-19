import Orion
import Foundation
import ViewControllerAnimatedC

class UIViewContorllerClassHook: ClassHook<UIViewController> {
  // static let targetName = "UIViewController";

  func viewDidLoad() {
    orig.viewDidLoad();

    if !VCAnimatedHelper.shared.isIllegalVC(vc: target) {
      target.transitioningDelegate = target;
    }
  }

  // orion:new
  func animationControllerForDismissedController(_ vc: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if !VCAnimatedHelper.shared.isIllegalVC(vc: target) {
      return VCAnimatedHelper.shared.dismissAnimator();
    }

    return orig.animationControllerForDismissedController(vc);
  }
}