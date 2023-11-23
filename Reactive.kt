import kotlin.Unit

class Iterator<A>(private val moveNext: () -> A) {
    fun <B> fmap(transform: (A) -> B): Iterator<B> {
        return Iterator { transform(moveNext()) }
    }
}

class Iterable<A>(private val getIterator: () -> Iterator<A>) {
    fun <B> fmap(transform: (A) -> B): Iterable<B> {
        return Iterable { getIterator().fmap(transform) }
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

typealias _Observer<A> = (A) -> Unit
typealias _Observable<A> = (_Observer<A>) -> Unit

class Observer<A>(val onNext: (A) -> Unit) {
    fun <B> contramap(transform: (B) -> A): Observer<B> {
        return Observer { b -> onNext(transform(b)) }
    }
}

class Observable<A>(val subscribe: (Observer<A>) -> Unit) {
    fun <B> fmap(transform: (A) -> B): Observable<B> {
        return Observable { observerB ->
            subscribe(Observer { a ->
                observerB.onNext(transform(a))
            })
        }
    }
}
