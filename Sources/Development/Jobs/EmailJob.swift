import Queue
import Node

public protocol Emailer {
  func email(address: String) throws
}

public struct EmailJob: Job {
  
  private var _body: Node
  public var body: Node? {
    return _body
  }
  
  private var emailer: Emailer?
  
  public static var queue: MemoryQueue<AnyJob> = MemoryQueue<AnyJob>(name: "email_queue")
  
  public init(body: Node) {
    self._body = body
  }
  
  public init(email: String) {
    self._body = try! Node(node: ["email": email])
  }
  
  public func run() throws {
    try self.emailer?.email(address: "")
  }
  
  public func create() throws {
    try EmailJob.queue.enqueue(job: AnyJob(self))
  }
  
}
