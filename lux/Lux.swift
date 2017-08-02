//
//  Lux.swift
//  lux
//
//  Created by Christopher Newton on 30.07.17.
//  Copyright © 2017 Newton Design. All rights reserved.
//

import Foundation

class Lux {
    
    public func set(level: Float) {
        var iterator: io_iterator_t = 0
        if IOServiceGetMatchingServices(kIOMasterPortDefault,
                                        IOServiceMatching("IODisplayConnect"),
                                        &iterator) == kIOReturnSuccess {
            var service: io_object_t = 1
            while service != 0 {
                service = IOIteratorNext(iterator)
                IODisplaySetFloatParameter(service,
                                           0,
                                           kIODisplayBrightnessKey as CFString!,
                                           level)
                IOObjectRelease(service)
            }
        }
    }
    
    public func getAverage() -> Float {
        var iterator: io_iterator_t = 0
        var cumulativeBrightness: Float = 0
        var activeDisplays: Int = 0
        if IOServiceGetMatchingServices(kIOMasterPortDefault,
                                        IOServiceMatching("IODisplayConnect"),
                                        &iterator) == kIOReturnSuccess {
            var service: io_object_t = 1
            while service != 0 {
                var brightnessValue: Float = 0.0
                service = IOIteratorNext(iterator)
                IODisplayGetFloatParameter(service,
                                           0,
                                           kIODisplayBrightnessKey as CFString,
                                           &brightnessValue)
                IOObjectRelease(service)
                if brightnessValue > 0 {
                    cumulativeBrightness += brightnessValue
                    activeDisplays += 1
                }
            }
        }
        return cumulativeBrightness / Float(activeDisplays)
    }
    
}
