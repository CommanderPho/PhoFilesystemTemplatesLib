//
//  File.swift
//
//
//  Created by Pho Hale on 1/25/21.
//

import Foundation



public protocol Node {
	var path: URL? {get set}
	//var depth: Int {get set}

	// Finalizes/Specifies the template but does not deploy it
	func build(validRoot: URL) throws

	// Actually performs the deploy action, for example creating the filesystem folders for a FilesystemTemplate
	func deploy() throws
}



//A Node representing a Folder on the filesystem which can be created by use of a FilesystemTemplate
public class FilesystemNode: Node {
	//The name of the node
	public var name = ""
	//The distance from the root node
	//var depth = 0
	//The root-relative path of the node
	public var path: URL?
	//The children of the node
	public var children = [Node]()

	public init(_ name: String, children: [Node] = []) {
		self.name = name
		self.children = children
		//Recurrsively set the depth of the children
		/**for child in self.children {
			child.depth = self.depth - 1
		}
		*/
	}

	//Builds the final (non-template) version of the current node and all its children
	public func build(validRoot: URL) throws {
		//For a Folder, the URL is simply the
		//self.path = validRoot.appendingPathComponent(self.name)
		self.path = validRoot.appendingPathComponent(self.name, isDirectory: true)
		//The children's root is the path of the current node
		guard let childrenValidRoot = self.path else {
			print("Newly built path is invalid!! \(self)")
			throw TemplateValidationError.invalidInternalPath
		}
		//Recurrsively build the children using the newly constructed path
		for child in self.children {
			try child.build(validRoot: childrenValidRoot)
		}
	}

	//Deploys the node to the filesystem
	public func deploy() throws {
		guard let validRoot = self.path else {
			throw TemplateDeploymentError.invalidInternalPath
		}
		debugPrint("Creating Path: \(validRoot)")
		try self.performCreate()
		//Recurrsively build the children using the newly constructed path
		for child in self.children {
			print("|-")
			try child.deploy()
		}
	}

	//Actually creates the directory
	fileprivate func performCreate() throws {
		guard let validRoot = self.path else {
			throw TemplateValidationError.invalidInternalPath
		}

		do {
			try FileManager.default.createDirectory(atPath: validRoot.path, withIntermediateDirectories: true, attributes: nil)
		} catch let error as NSError {
			print(error.localizedDescription);
			throw TemplateDeploymentError.createDirectoryError(error: error)
		}
	}

//	public func setFinderTags() {
//		var rv = URLResourceValues()
//		rv.labelNumber = 2
//
//		do {
//			try self.path?.setResourceValues(rv)
//		} catch {
//			print(error.localizedDescription)
//		}
//	}
}


//A Node representing a symbolic link
// Finalize will create the symbolic link at path to its target property
public class SymlinkNode: FilesystemNode {
	//Target node must be a filesystemNode
	public var targetNode: FilesystemNode

	public init(_ name: String, target: FilesystemNode) {
		self.targetNode = target
		super.init(name, children: [])
	}

	public override func performCreate() throws {
		guard let validRoot = self.path else {
			throw TemplateValidationError.invalidInternalPath
			fatalError("Couldn't create symlink!")
		}
		guard let validTarget = self.targetNode.path else {
			print("Couldn't find symlink target \(self.targetNode)!")
			throw TemplateValidationError.noSymlinkTargetSpecified
		}

		do {
			try FileManager.default.createSymbolicLink(at: validRoot, withDestinationURL: validTarget)
			//try FileManager.default.createDirectory(atPath: finalValidPath.path, withIntermediateDirectories: true, attributes: nil)
		} catch let error as NSError {
			print(error.localizedDescription);
			throw TemplateDeploymentError.createSymbolicLinkError(error: error)
		}
	}

}



