import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var coin: UIImageView!
    @IBOutlet private weak var emailView: UIStackView!
    @IBOutlet private weak var rememberMeBtn: UIButton!
    @IBOutlet private weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        animateLogo()
        showLoginContent()
    }
    
    private func initView() {
        roundView(with: emailView)
        roundView(with: loginBtn)
    }
    
    private func roundView(with view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 25
    }
    
    private func animateLogo() {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.duration = 1
        animation.fromValue = self.view.frame.width / 2
        animation.toValue = self.coin.frame.width / 4 + 16
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        self.coin.layer.add(animation, forKey: "position.x")
    }
    
    private func showLoginContent(){
        UIView.animate(withDuration: 1, animations: {
            self.emailView.alpha = 1
            self.rememberMeBtn.alpha = 1
            self.loginBtn.alpha = 1
        })
    }
}

