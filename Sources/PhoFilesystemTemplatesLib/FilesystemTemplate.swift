//
//  FilesystemTemplate.swift
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

	// Ensures that all needed parameters are valid and the deploy() action can succeed. Much like a dry-run of deploy()
	func validate() throws

	// Actually performs the deploy action, for example creating the filesystem folders for a FilesystemTemplate
	func deploy() throws
	
}







//A template to create filesystem structures
public class FilesystemTemplate: Template {

	public var templateName: String = "Default Filesystem Template"
	public var templateDescription: String = "Creates filesystem objects"
	public var rootNode: FilesystemNode
	public private(set) var deployPath: URL?


	////////////////////////////////////////////////////////////////////
	//MARK: -
	//MARK: - Initializers

	public init(rootNode: FilesystemNode, templateName: String = "Default Filesystem Template", templateDescription: String = "Creates filesystem objects", defaultDeployPath: URL? = nil) {
		self.templateName = templateName
		self.templateDescription = templateDescription
		self.rootNode = rootNode
//		self.deployPath = defaultDeployPath
		if let validUrl = defaultDeployPath {
			self.updateDeployPath(validUrl)
		}
	}

	////////////////////////////////////////////////////////////////////
	//MARK: -
	//MARK: - Functions

	public func updateDeployPath(_ path: URL) {
		self.deployPath = path
		do {
			try self.validate()
		} catch let error {
			print("validate() failed with error: \(error).\n Template still not deployable.")
//			fatalError("error: \(error)")
		}
	}


	//Validates the current template to see if all paths exist and are tenable
	public func validate() throws {
		guard let validRoot = self.deployPath else {
			throw TemplateValidationError.invalidInternalPath
		}
		//Otherwise we try to use the validRoot to build all children objects recurrsively from the root
		try self.rootNode.build(validRoot: validRoot)
		//If no fatal errors are thrown, then we're good!
	}


	public func deploy() throws {
		try self.deploy(specifyingDeployPath: nil)
	}

	//Actually performs the action for a specific template (like creating the filesystem entries on disk)
	public func deploy(specifyingDeployPath deployPath: URL?) throws {
		// If the user specified a deploy path, set that before deploying
		if let validOverrideDeployPath = deployPath {
			self.deployPath = validOverrideDeployPath
			// Check: this object doesn't need to be built or anything after setting self.deployPath, right?
		}
		try self.rootNode.deploy()
	}

}

