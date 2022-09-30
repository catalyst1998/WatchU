//
//  HealthStore.swift
//  BrushUTooth WatchKit Extension
//
//  Created by bytedance on 2022/9/29.
//

import Foundation
import HealthKit

final class HealthStore {
    // singleton
    static let shared = HealthStore()
    
    // a variable to hold the `HKHealthStore`
    private var healthStore: HKHealthStore?
    
    // private initializer to make sure that the callers must use shared singleton instance
    private init() {
        guard HKHealthStore.isHealthDataAvailable() else {
            return
        }
        
        healthStore = HKHealthStore()
    }
    
    /// Saving data to Apple Health is an asynchronous operation.
    ///  All data types convert to an HKSample before saving.
    private func saveData(_ sample: HKSample) async throws {
        // if HealthStore wasn't set throw a error
        guard let healthStore = healthStore else {
            throw HKError(.errorHealthDataUnavailable)
        }
            // `withCheckedThrowingContinuation` takes a body of codes and pause
            // until `CheckedContiutation` is called.
        let _: Bool = try await withCheckedThrowingContinuation({ continuation in
            
            // save sample to Apple Health
            healthStore.save(sample) { _, error in
                // if asynchronous save failed,then throw to error
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                continuation.resume(returning: true)
            }
        })
    }
    
    private let brushCategoryType = HKCategoryType.categoryType(forIdentifier: .toothbrushingEvent)!
    
}
