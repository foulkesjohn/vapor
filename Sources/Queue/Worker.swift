import Foundation
import Node

public protocol Worker {
  func run() throws
  func stop()
}

public typealias VaporQueue = AnyQueue<Job>

public struct WorkerOptions {
  public let sleep: TimeInterval
  public let max: Int
  
  static let defaultOptions = WorkerOptions(sleep: 5,
                                            max: 1)
}

public class DefaultWorker: Worker {
  
  private var _queue: VaporQueue
  private var _failedQueue: VaporQueue
  private var _options: WorkerOptions
  
  public init(queue: VaporQueue,
              failedQueue: VaporQueue,
              options: WorkerOptions = WorkerOptions.defaultOptions) {
    self._queue = queue
    self._failedQueue = failedQueue
    self._options = options
  }
  
  public func run() throws {
    var job: Job? = nil
    //horrible, refactor me
    do {
      job = try self._queue.dequeue()
      if let job = job {
        try job.run()
      } else {
        Thread.sleep(forTimeInterval: self._options.sleep)
      }
    } catch {
      do {
        if let failedJob = job {
          try self._failedQueue.enqueue(job: failedJob)
        }
      } catch {
        //log failed?
      }
    }
  }
  
  public func stop() {
    
  }
}

extension DefaultWorker {
  public static var worker = DefaultWorker(queue: AnyQueue(MemoryQueue<Job>(name: "default_queue")),
                                           failedQueue: AnyQueue(MemoryQueue<Job>(name: "failed_queue")))
}
