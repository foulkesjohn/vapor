import Node

public protocol Job {
  var body: Node? { get }
  init(body: Node)
  func run() throws
  func create() throws
}

public struct AnyJob: Job {
  
  private var _job: Job?
  public var body: Node? { return self._job?.body }
  
  public init<Base: Job>(_ base: Base) {
    _job = base
  }
  
  public init(body: Node) { }
  
  public func run() throws {
    try self._job?.run()
  }
  
  public func create() throws {
    try self._job?.create()
  }
}
