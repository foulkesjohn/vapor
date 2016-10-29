import Foundation

public final class MemoryQueue<T>: Queue {
  
  public typealias JobType = T
  
  public internal(set) var name: String
  
  private var queue: [T] = []
  
  public init(name: String) {
    self.name = name
  }
  
  public func enqueue(job: T) throws {
    self.queue.append(job)
  }
  
  public func dequeue() throws -> T? {
    var job: T? = nil
    if self.queue.count > 0 {
      job = self.queue.removeFirst()
    }
    return job
  }
}
