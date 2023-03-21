import Foundation

public extension F {
    static func mapOptional<S: Sequence, A>(_ fun: @escaping (S.Element) -> A?) -> (S) -> [A] {
        return { sequence in sequence.compactMap(fun) }
    }

    static func flatMap<S: Sequence, A>(_ fun: @escaping (S.Element) -> [A]) -> (S) -> [A] {
        return { sequence in sequence.flatMap(fun) }
    }

    static func contains<S: Sequence>(_ value: S.Element) -> (S) -> Bool where S.Element: Equatable {
        return { sequence in sequence.contains(value) }
    }

    static func contains<S: Sequence>(where predicate: @escaping (S.Element) -> Bool) -> (S) -> Bool {
        return { sequence in sequence.contains(where: predicate) }
    }

    static func filter<S: Sequence>(_ predicate: @escaping (S.Element) -> Bool) -> (S) -> [S.Element] {
        return { sequence in sequence.filter(predicate) }
    }

    static func flatMap<S: Sequence, T: Sequence>(_ fun: @escaping (S.Element) -> T) -> (S) -> [T.Element] {
        return { sequence in sequence.flatMap(fun) }
    }

    static func forEach<S: Sequence>(_ fun: @escaping (S.Element) -> Void) -> (S) -> Void {
        return { sequence in sequence.forEach(fun) }
    }

    static func map<S: Sequence, A>(_ transform: @escaping (S.Element) -> A) -> (S) -> [A] {
        return { $0.map(transform) }
    }

    static func reduce<A, S: Sequence>(_ fun: @escaping (A, S.Element) -> A) -> (A) -> (S) -> A {
        { initial in
            { sequence in sequence.reduce(initial, fun) }
        }
    }

    static func reduceInto<A, S: Sequence>(_ fun: @escaping (inout A, S.Element) -> Void) -> (A) -> (S) -> A {
        { initial in
            { sequence in sequence.reduce(into: initial, fun) }
        }
    }

    static func sorted<S: Sequence>(_ sequence: S) -> [S.Element] where S.Element: Comparable {
        return sequence.sorted()
    }

    static func sorted<S: Sequence>(by fun: @escaping (S.Element, S.Element) -> Bool) -> (S) -> [S.Element] {
        return { sequence in sequence.sorted(by: fun) }
    }

    static func mutEach<C: MutableCollection>(_ transform: @escaping (inout C.Element) -> Void) -> (inout C) -> Void {
        return {
            for idx in $0.indices {
                transform(&$0[idx])
            }
        }
    }

    static func partition<A: Sequence>(_ predicate: @escaping (A.Element) -> Bool) -> (A) -> ([A.Element], [A.Element]) {
      return { sequence in
        sequence.reduce(into: ([], [])) { accum, value in
          predicate(value) ? accum.0.append(value) : accum.1.append(value)
        }
      }
    }

}
