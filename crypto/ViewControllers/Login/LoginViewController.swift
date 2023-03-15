import UIKit
import Combine

final class LoginViewController: UIViewController {

    private let viewModel = LoginViewModel.shared
    private var bindings = Set<AnyCancellable>()
    
    @IBOutlet private weak var coin: UIImageView!
    @IBOutlet private weak var emailView: UIStackView!
    @IBOutlet private weak var rememberMeBtn: UIButton!
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet private weak var emailLabel: UILabel!
    
    private var email = "" {
        didSet {
            emailLabel.text = email
        }
    }
    private var isLoginEnabled = false {
        didSet {
            loginBtn.alpha = isLoginEnabled ? 1 : 0.5
            loginBtn.isEnabled = isLoginEnabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        initView()
        animateLogo()
        showLoginContent()
    }
    
    private func bindViewModel() {
        viewModel.$email
            .assign(to: \.email, on: self)
            .store(in: &bindings)
        viewModel.$isLoginEnabled
            .assign(to: \.isLoginEnabled, on: self)
            .store(in: &bindings)
    }
    
    private func initView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        roundView(with: emailView)
        roundView(with: loginBtn)
        rememberMeBtn.setImage(UIImage(systemName: "square"), for: .normal)
        rememberMeBtn.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        emailView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openGoogleView)))
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
    
    @objc private func openGoogleView() {
        viewModel.signIn(self)
    }
    
    @IBAction func onLoginBtnClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    @IBAction func onCheckboxClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        viewModel.rememberUser(sender.isSelected)
    }
    
//    for logout
//    @IBAction func logoutTapped(_ sender: UIButton) {
//        // ...
//            // after user has successfully logged out
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
//
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
//    }
}

