//
//  File.swift
//  
//
//  Created by Pho Hale on 1/25/21.
//

import Foundation


////////////////////////////////////////////////////////////////////
//MARK: -
//MARK: - An error that can occur while deploying a template
enum TemplateDeploymentError: Error {
	case invalidInternalPath
	case createSymbolicLinkError(error: NSError)
	case createDirectoryError(error: NSError)
	case unknownError
}


enum TemplateValidationError: Error {
	case invalidInternalPath
	case noSymlinkTargetSpecified
	case unknownError
}


