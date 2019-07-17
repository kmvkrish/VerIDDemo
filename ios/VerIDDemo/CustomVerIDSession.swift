//
//  CustomVerIDSession.swift
//  VerIDDemo
//
//  Created by VARANASI, KRISHNA MANOJ (CORP) on 17/07/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

import VerIDCore
import VerIDUI

@objc class CustomVerIDSession: VerIDSession {
  
  @objc public var vc: (UIViewController & VerIDViewControllerProtocol)?
  
  private var videoWriterService: VideoWriterService?
  private var faceDetection: FaceDetectionService?
  private var retryCount = 0
  private var startTime: Double = 0
  private var startDispatchTime: DispatchTime = .now()
  
  private var navigationController: UINavigationController?
  
  private var image: VerIDImage?
  private let imageLock = DispatchSemaphore(value: 0)
  
  private let imageAcquisitionSignposting = Signposting(category: "Image acquisition")
  
  private var imageQueue: DispatchQueue?
  
  private lazy var operationQueue: OperationQueue = {
    let queue = OperationQueue()
    queue.qualityOfService = .userInitiated
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
  
  override init(environment: VerID, settings: VerIDSessionSettings) {
    super.init(environment: environment, settings: settings)
  }
  
  @objc override func start() {
    DispatchQueue.main.async {
      if let videoURL = self.settings.videoURL, let videoWriterFactory = self.videoWriterFactory {
        if FileManager.default.isDeletableFile(atPath: videoURL.path) {
          try? FileManager.default.removeItem(at: videoURL)
        }
        self.videoWriterService = try? videoWriterFactory.makeVideoWriterService(url: videoURL)
      }
      
      if UIApplication.shared.keyWindow?.rootViewController == nil {
        self.delegate?.session(self, didFinishWithResult: VerIDSessionResult(error: SessionError.failedToStart))
        return
      }
      
      do {
        self.vc = try self.sessionViewControllersFactory.makeVerIDViewController()
      } catch {
        self.showResult(VerIDSessionResult(error: error))
        return
      }
      
      self.vc?.delegate = self
    }
  }
  
  @objc override func cancel() {
    self.operationQueue.cancelAllOperations()
    self.vc = nil
    DispatchQueue.main.async {
      self.delegate?.sessionWasCanceled(self)
    }
  }
  
  @objc public func startOperations() -> Void {
    self.imageQueue = DispatchQueue(label: "com.appliedrec.image", qos: .userInitiated, attributes: [], autoreleaseFrequency: .inherit, target: nil)
    self.viewController?.clearOverlays()
    self.startTime = CACurrentMediaTime()
    self.startDispatchTime = .now()
    self.faceDetection = nil
    do {
      self.faceDetection = try self.faceDetectionFactory.makeFaceDetectionService(settings: self.settings)
    } catch {
      self.showResult(VerIDSessionResult(error: error))
      return
    }
    
    let op = SessionOperation(imageProvider: self, faceDetection: self.faceDetection!, resultEvaluation: self.resultEvaluationFactory.makeResultEvaluationService(settings: self.settings), imageWriter: try? self.imageWriterFactory.makeImageWriterService())
    op.delegate = self
    let finishOp = BlockOperation()
    
    finishOp.addExecutionBlock { [weak finishOp, weak self] in
      if finishOp != nil && finishOp!.isCancelled {
        return
      }
      self?.imageQueue = nil
      if let videoWriter = self?.videoWriterService {
        videoWriter.finish() { url in
          op.result.videoURL = url
          self?.showResult(op.result)
        }
      } else {
        self?.showResult(op.result)
      }
    }
  }
  
  private func showResult(_ result: VerIDSessionResult) -> Void {
    self.operationQueue.cancelAllOperations()
    self.finishWithResult(result)
  }
  
  private func finishWithResult(_ result: VerIDSessionResult) -> Void {
    
  }
  
}

