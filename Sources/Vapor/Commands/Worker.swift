import Console
import Queue
import Dispatch

public final class WorkerCommand: Command {
  
  public let id = "worker"
  public let help = [""]
  
  public let console: ConsoleProtocol
  
  private let worker: Worker
  private let queue = DispatchQueue.global(qos: .background)
  
  public init(console: ConsoleProtocol,
              worker: Worker) {
    self.console = console
    self.worker = worker
  }
  
  public func run(arguments: [String]) throws {
    queue.async {
      while true {
        do {
          try self.worker.run()
        } catch {
          
        }
      }
    }
  }
}
