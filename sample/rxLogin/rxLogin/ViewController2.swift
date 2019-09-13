//
//  ViewController.swift
//  rxLogin
//
//  Created by hyuni on 2019. 9. 12..
//  Copyright © 2019년 dreamford. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ObserverType where E == Void {
	public func onNext() {
		onNext(())
	}
}


// Mark - LoginViewModelInputs
protocol LoginViewModelInputs {
//	func usernameChanged(_ username: String)
//	func passwordChanged(_ password: String)
//	func loginTapped()
}

// Mark - LoginViewModelOutputs
protocol LoginViewModelOutputs {
//	var loginButtonEnabled: Observable<Bool> { get }
//	var showSuccessMessage: Observable<String> { get }
}

// Mark - LoginViewModelType
protocol LoginViewModelType {
	var inputs: LoginViewModelInputs { get }
	var outputs: LoginViewModelOutputs { get }
}


class LoginViewModel: LoginViewModelInputs,  LoginViewModelOutputs,  LoginViewModelType {
	var inputs: LoginViewModelInputs { return self }
	var outputs: LoginViewModelOutputs { return self }
	
//	var loginButtonEnabled: Observable<Bool>
//	var showSuccessMessage: Observable<String>
//
//	init() {
//		self.loginButtonEnabled = Observable.combineLatest(
//			_usernameChanged,
//			_passwordChanged
//		) { username, password in
//			return !username.isEmpty && !password.isEmpty
//		}
//
//		self.showSuccessMessage = _loginTapped.map { "Login Successful" }
//	}
//	private let _usernameChanged = PublishSubject<String>()
//	private let _passwordChanged = PublishSubject<String>()
//	private let _loginTapped = PublishSubject<Void>()
//
//	func usernameChanged(_ username: String) {
//		_usernameChanged.onNext(username)
//	}
//	func passwordChanged(_ password: String) {
//		_passwordChanged.onNext(password)
//	}
//	func loginTapped() {
//		_loginTapped.onNext()
//	}
	init() {
	}
	
	func bind(
		usernameChanged: Observable<String>,
		passwordChanged: Observable<String>,
		loginTapped: Observable<Void>) ->
		(
			loginButtonEnabled: Observable<Bool>,
			showSuccessMessage: Observable<String>
		) {
		let loginButtonEnabled = Observable.combineLatest(usernameChanged, passwordChanged) { username, password in
			!username.isEmpty && !password.isEmpty
		}
		
		let showSuccessMessage = loginTapped.map { "Login Successful!" }
		
		return (loginButtonEnabled, showSuccessMessage)
	}
}


class ViewController: UIViewController {
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var messageLabel: UILabel!
	
	private var viewModel: LoginViewModelType!
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		binding()
	}
	
	func binding() {
		self.viewModel = LoginViewModel()
		
		guard let viewModel1 = self.viewModel as? LoginViewModel else {
			return
		}
		
		//let viewModel1: LoginViewModel = (LoginViewModel) self.viewModel
		
		let (
			loginButtonEnabled,
			showSuccessMessage
		) = viewModel1.bind(
			usernameChanged: usernameTextField.rx.text.orEmpty.asObservable(),
			passwordChanged: passwordTextField.rx.text.orEmpty.asObservable(),
			loginTapped: loginButton.rx.tap.asObservable()
		)
		
		disposeBag.insert(

			loginButtonEnabled.bind(to: loginButton.rx.isEnabled),
			showSuccessMessage.subscribe(onNext: { message in
				print(message)
				self.messageLabel.text = message
			})
		)
	}
}

