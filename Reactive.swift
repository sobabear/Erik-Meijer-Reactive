
import Foundation

struct Iterator<A> {
    let moveNext: () -> A
}

extension Iterator {
    func fmap<B>(_ transform: @escaping (A) -> B) -> Iterator<B> {
        return Iterator<B> { transform(self.moveNext()) }
    }
}

struct Iterable<A> {
    let getIterator: () -> Iterator<A>
}

extension Iterable {
    func fmap<B>(_ transform: @escaping (A) -> B) -> Iterable<B> {
        return Iterable<B> {
            self.getIterator().fmap(transform)
        }
    }
}


/// Covariant: 
/// A <: B
/// () -> A <: () ->  B

/// Contravariant:
/// A <: B
/// () -> B  <: () -> A

// Apply Duality
typealias _Iterator<A> = () -> A
typealias _Iterable<A> = () -> Iterator<A>

typealias _Observer<A> = (A) -> Void
typealias _Observable<A> = (_Observer<A>) -> Void

/// AS you see Observer can be SETTER
/// obsevable can be Setter of Setter

/// Iterator is GETTER
/// Iterable is Getter of Getter





struct Observer<A> {
    let onNext: (A) -> Void
}

extension Observer {
    func contramap<B>(_ transform: @escaping (B) -> A) -> Observer<B> {
        return Observer<B> { b in
            self.onNext(transform(b))
        }
    }
}

struct Observable<A> {
    let subscribe: (Observer<A>) -> Void
}

extension Observable {
    func fmap<B>(_ transform: @escaping (A) -> B) -> Observable<B> {
        return Observable<B> { observerB in
            self.subscribe(Observer<A> { a in
                observerB.onNext(transform(a))
            })
        }
    }
}



// Practice

let observable = Observable<Int>.init { observer in
    Task {
        observer.onNext(3)
        observer.onNext(4)
        try! await Task.sleep(nanoseconds: 5_000_000_000)
        observer.onNext(100)
    }
}


let observer = Observer<Int>.init(onNext: { print("value: \($0)") })

observable.subscribe(observer)

