//
//  FilesystemTemplate.swift
//  
//
//  Created by Pho Hale on 1/25/21.
//

import Foundation


//A template to create filesystem structures
public class FilesystemTemplate: Template {
	public var templateName: String = "Default Filesystem Template"
	public var templateDescription: String = "Creates filesystem objects"
	public var rootNode: FilesystemNode
	public var deployPath: URL?

	public init(rootNode: FilesystemNode, defaultPath: URL?) {
		self.rootNode = rootNode
		self.deployPath = defaultPath
		self.validate()
	}

	//Validates the current template to see if all paths exist and are tenable
	public func validate() {
		guard let validRoot = self.deployPath else {
			fatalError("Couldn't validate internal path!")
		}
		//Otherwise we try to use the validRoot to build all children objects recurrsively from the root
		self.rootNode.build(validRoot: validRoot)
		//If no fatal errors are thrown, then we're good!
	}

	//Actually performs the action for a specific template (like creating the filesystem entries on disk)
	public func deploy() {
		self.rootNode.deploy()
	}

}

