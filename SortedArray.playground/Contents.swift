import Foundation

struct SortedArray<Element: Comparable> {
    var elements: [Element]
    
    init<S: Sequence>(unsorted: S) where S.Iterator.Element == Element {
        elements = unsorted.sorted()
    }
    
    mutating func insert(_ element: Element) {
        elements.append(element)
        elements.sort()
    }
    
    func index(for element: Element) -> Int {
        var start = elements.startIndex
        var end = elements.endIndex
        while start < end {
            let middle = start + (end - start) / 2
            if elements[middle] < element {
                start = middle + 1
            } else {
                end = middle
            }
        }
        assert(start == end)
        return start
    }
    
    mutating func insert2(_ element: Element) {
        elements.insert(element, at: index(for: element))
    }
    
    func contains2(element: Element) -> Bool {
        let index = self.index(for: element)
        guard index < elements.endIndex else { return false }
        return self[index] == element
    }
}

var test = SortedArray<Int>(unsorted: [])
test.insert2(5)
test.insert2(4)
test.insert2(6)
test.elements

extension SortedArray: Collection {
    var startIndex: Int {
        return elements.startIndex
    }
    
    var endIndex: Int {
        return elements.endIndex
    }
    
    subscript(index: Int) -> Element {
        return elements[index]
    }
    
    func index(after i: Int) -> Int {
        return elements.index(after: i)
    }
    
    func min() -> Element? {
        return elements.first
    }
}


