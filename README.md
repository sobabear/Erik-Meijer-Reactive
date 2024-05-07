# Reactive Programming

This repository contains an example of reactive programming, illustrating key functional programming concepts such as covariance and contravariance, implemented through custom types like `Iterator`, `Iterable`, `Observer`, and `Observable`.

## Overview

Reactive programming is a programming paradigm oriented around data streams and the propagation of change. This means it makes it easy to react to data as it changes over time and respond with new actions. This implementation showcases how to handle asynchronous data streams using `Observer` and `Observable` structures.

### Covariance and Contravariance

In the context of type theory:

- **Covariance**: Allows a function to be written in a general way, making it possible to substitute a type with a subtype without affecting the correctness of the program.
- **Contravariance**: Allows a function to accept parameters of a less specific type than initially specified, which is useful in cases like function arguments.

#### Definitions
- **Covariant**:
  - `A <: B` implies `() -> A <: () -> B`
  - Here, if type `A` is a subtype of `B`, then a function returning `A` can be substituted by a function returning `B`.

- **Contravariant**:
  - `A <: B` implies `() -> B <: () -> A`
  - Here, if type `A` is a subtype of `B`, then a function accepting `A` as a parameter can be replaced with a function accepting `B`.

### Structures Defined

- **Iterator<A>**: Represents a basic iterator, able to transform its output through a `fmap` operation.
- **Iterable<A>**: A collection capable of returning an iterator that can iterate over its elements.
- **Observer<A>**: Designed to react to notifications or data changes.
- **Observable<A>**: Manages observers and notifies them about changes in data.

### Reactive Extensions

- `Iterator` and `Iterable` demonstrate **covariance** with the `fmap` method, allowing transformation of elements from one type to another while maintaining type safety.
- `Observer` shows **contravariance** with the `contramap` method, which prepares the observer to handle inputs of a different type by transforming them to the expected type before processing.

## Reference
- https://www.slideshare.net/EddyBertoluzzo/the-essence-of-reactive-programming-67448077
