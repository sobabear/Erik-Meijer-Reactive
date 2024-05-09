import Foundation
/// ERROR
//var any1: Any = String()
//var int1: Int = any1

var int2: Int = 1
var any2: Any = int2


/// ERROR
//var intClosure1: (Int) -> Void = { num in print(num) }
//var anyClosure1: (Any) -> Void = intClosure1

var anyClosure2: (Any) -> Void = { `any` in print(`any`) }
var intClosure2: (Int) -> Void = anyClosure2

/// ERROR
//var anyResolverClosure1: ((Any) -> Void) -> Void = { f in f(String()) }
//var intResolverClosure1: ((Int) -> Void) -> Void = anyResolverClosure
var intResolverClosure2: ((Int) -> Void) -> Void = { f in f(Int()) }
var anyResolverClosure2: ((Any) -> Void) -> Void = intResolverClosure2




let intBuilder: () -> Int = { return 1 }
let anyBuilder: () -> Any = intBuilder
/// Int < Any
/// () -> Int < ()-> Any
/// -> Covariant
/// getter

var anyClosure: (Any) -> Void = { `any` in print(`any`) }
var intClosure: (Int) -> Void = anyClosure2

/// Int < Any
/// (Any) -> Void < (Int)-> Void
/// -> Contravarient
/// setter

let intclosureClosure: () -> (() -> Int) = {
    return {
        return 1
    }
}
let anyclosureClosure: () -> (() -> Any) = intclosureClosure
/// -> Covariant
/// getter getter
///

//typealias IINT = (Int -> Void)
//typealias AANy = (Any -> Void)
let intResolverClosure: ((Int) -> Void) -> Void = { f in
    f(1000)
}

let anyResolverClosure: ((Any) -> Void) -> Void = intResolverClosure

/// Int < Any
/// ((Int) -> Void) -> Void < ((Any)-> Void) -> Void
/// -> Covariant?
/// Setter Setter
/// -> ContraVariant
///
///
// ===================


let anyResolver: (Any) -> Void = { print($0) }
let intResolver: (Int) -> Void = { print($0) }
anyResolverClosure(intResolver)

intResolverClosure(anyResolver)
