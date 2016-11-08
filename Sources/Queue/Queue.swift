import Node
import Foundation

public protocol Queue {
  associatedtype JobType
  var name: String { get }
  func enqueue(job: JobType) throws
  func dequeue() throws -> JobType?
}

public struct AnyQueue<JobT>: Queue {
  
  public typealias JobType = JobT
  
  private let _dequeue: () throws -> JobT?
  private let _enqueue: (JobT) throws -> ()
  public internal(set) var name: String
  
  public init<Base: Queue>(_ base: Base) where JobT == Base.JobType {
    self._dequeue = base.dequeue
    self._enqueue = base.enqueue
    self.name = base.name
  }
  
  public func dequeue() throws -> JobT? { return try self._dequeue() }
  public func enqueue(job: JobT) throws { try self._enqueue(job) }
}
