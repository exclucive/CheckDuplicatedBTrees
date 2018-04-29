//: Playground - noun: a place where people can play

/*
Check if a Binary Tree contains duplicate subtrees of size 2 or more
Given a Binary Tree, check whether the Binary tree contains a duplicate sub-tree of size 2 or more.
Note : Two same leaf nodes are not considered as subtree size of a leaf node is one.

Input :  Binary Tree
        A
      /    \
     B      C
   /   \     \
  D     E     B
             /  \
            D    E
Output : Yes
*/
 
import UIKit

class BinaryTree<T>: Equatable {
    let value: T
    var left: BinaryTree<T>?
    var right: BinaryTree<T>?

    init(value: T) {
        self.value = value
    }
    
    func serialize() -> String {
        var result = "\(value)"
        if let l = left {
            result += l.serialize()
        }
        if let r = right {
            result += r.serialize()
        }
        
        return result
    }
    
    public static func ==(lhs: BinaryTree<T>, rhs: BinaryTree<T>) -> Bool {
        return lhs.serialize() == rhs.serialize()
    }
}

func isTreeContainDuplicates(_ tree: Tree) -> Bool {
    var map:[String: Int] = [:]
    containDuplicateSubtrees(tree, map: &map)
    
    return map.values.filter { (value) -> Bool in
        value >= 2
        }.count > 0
}


func containDuplicateSubtrees(_ tree: Tree, map: inout [String: Int]) {
    let key = tree.serialize()
    // dont add leafs to hash
    if key.count > 1 {
        if let counter = map[key] {
            map[key] = counter + 1
        }
        else {
            map[key] = 1
        }
    }
    
    if let left = tree.left {
        containDuplicateSubtrees(left, map: &map)
    }
    if let right = tree.right {
        containDuplicateSubtrees(right, map: &map)
    }
}

typealias Tree = BinaryTree<String>

let rootA = Tree(value: "A")

let c = Tree(value: "C")

let b = Tree(value: "B")
let d = Tree(value: "D")
let e = Tree(value: "E")

let b1 = Tree(value: "B")
let d1 = Tree(value: "D")
let e1 = Tree(value: "E")

rootA.left = b
rootA.right = c
b.left = d
b.right = e

c.right = b1
b1.left = d1
b1.right = e1

isTreeContainDuplicates(rootA)

