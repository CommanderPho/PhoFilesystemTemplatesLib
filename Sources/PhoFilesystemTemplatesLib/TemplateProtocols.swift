//
//  File.swift
//  
//
//  Created by Pho Hale on 1/25/21.
//

import Foundation


public protocol Template {
	//The name of the template
	var templateName: String {get set}
	//A description of the template
	var templateDescription: String {get set}
}


public protocol Node {
	var path: URL? {get set}
	//var depth: Int {get set}

	func build(validRoot: URL)
	func deploy()
}

