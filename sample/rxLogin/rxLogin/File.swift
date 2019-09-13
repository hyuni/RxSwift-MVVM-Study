//
//  File.swift
//  rxLogin
//
//  Created by hyuni on 2019. 9. 13..
//  Copyright © 2019년 dreamford. All rights reserved.
//

import Foundation

extension ObserverType where E == Void {
	public func onNext() {
		onNext(())
	}
}

protocol ViewModelInputs {}
protocol ViewModelOutputs {}

protocol BaseViewModelType: class {}

protocol ViewModelType: BaseViewModelType {
	associatedtype Inputs = ViewModelInputs
	associatedtype Outputs = ViewModelInputs
	
	var inputs: Inputs { get }
	var outputs: Outputs { get }
}

// Mark - <#Name#>ViewModelInputs
protocol <#Name#>ViewModelInputs: ViewModelInputs {
}

// Mark - <#Name#>ViewModelOutputs
protocol <#Name#>ViewModelOutputs: ViewModelOutputs {
}

// Mark - <#Name#>ViewModelType
protocol <#Name#>ViewModelType: ViewModelType {
	typealias Inputs = <#Name#>ViewModelInputs
	typealias Outputs = <#Name#>ViewModelOutputs
}


class <#Name#>ViewModel: <#Name#>ViewModelInputs,  <#Name#>ViewModelOutputs,  <#Name#>ViewModelType {
	var inputs: Inputs { return self }
	var outputs: Outputs { return self }
	init() {
	}
}
