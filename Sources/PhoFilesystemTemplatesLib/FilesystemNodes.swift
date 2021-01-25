//
//  File.swift
//
//
//  Created by Pho Hale on 1/25/21.
//

import Foundation

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

	public init(name: String, children: [Node]) {
		self.name = name
		self.children = children
		//Recurrsively set the depth of the children
		/**for child in self.children {
			child.depth = self.depth - 1
		}
		*/
	}

	//Builds the final (non-template) version of the current node and all its children
	public func build(validRoot: URL) {
		//For a Folder, the URL is simply the
		//self.path = validRoot.appendingPathComponent(self.name)
		self.path = validRoot.appendingPathComponent(self.name, isDirectory: true)
		//The children's root is the path of the current node
		guard let childrenValidRoot = self.path else {
			fatalError("Newly built path is invalid!! \(self)")
		}
		//Recurrsively build the children using the newly constructed path
		for child in self.children {
			child.build(validRoot: childrenValidRoot)
		}
	}

	//Deploys the node to the filesystem
	public func deploy() {
		guard let validRoot = self.path else {
			fatalError("Couldn't validate internal path!")
		}
		debugPrint("Creating Path: \(validRoot)")
		self.finalize()
		//Recurrsively build the children using the newly constructed path
		for child in self.children {
			print("|-")
			child.deploy()
		}
	}

	//Actually creates the directory
	public func finalize() {
		guard let validRoot = self.path else {
			fatalError("Couldn't validate internal path!")
		}

		do {
			try FileManager.default.createDirectory(atPath: validRoot.path, withIntermediateDirectories: true, attributes: nil)
		} catch let error as NSError {
			print(error.localizedDescription);
		}
	}

	public func setFinderTags() {
		var rv = URLResourceValues()
		rv.labelNumber = 2

		do {
			try self.path?.setResourceValues(rv)
		} catch {
			print(error.localizedDescription)
		}
	}
}


//A Node representing a symbolic link
// Finalize will create the symbolic link at path to its target property
public class SymlinkNode: FilesystemNode {
	//Target node must be a filesystemNode
	public var targetNode: FilesystemNode

	public init(name: String, target: FilesystemNode) {
		self.targetNode = target
		super.init(name: name, children: [])
	}

	public override func finalize() {
		guard let validRoot = self.path else {
			fatalError("Couldn't create symlink!")
		}
		guard let validTarget = self.targetNode.path else {
			fatalError("Couldn't find symlink target \(self.targetNode)!")
		}

		do {
			try FileManager.default.createSymbolicLink(at: validRoot, withDestinationURL: validTarget)
			//try FileManager.default.createDirectory(atPath: finalValidPath.path, withIntermediateDirectories: true, attributes: nil)
		} catch let error as NSError {
			print(error.localizedDescription);
		}
	}

}



