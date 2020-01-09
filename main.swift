#!/usr/bin/env xcrun swift

import Foundation

let constMultiplier = 2.5
let args = CommandLine.arguments

if args.count > 3 {
	print("Too many arguments")
	exit(1)
} else if args.count < 3 {
	print("Too few arguments")
	exit(1)
}

func transformToArray(_ arg: String) -> [Double] {
    return arg.split(separator: ",").map {
        if let item = Double($0.trimmingCharacters(in: .letters).trimmingCharacters(in: .whitespacesAndNewlines)) {
            return item
        } else {
            print("Bad input")
            exit(1)
        }
    }
}

class PixelAverage {
    let pixA: [Double]
    let pixB: [Double]

    init(pixA: [Double], pixB: [Double]) {
        self.pixA = pixA
        self.pixB = pixB
    }

    func normalizePixel() -> [Double] {
        return normalize(average())
    }
    
    private func average() -> [Double] {
        guard !pixA.isEmpty else { return pixB }
        guard !pixB.isEmpty else { return pixA }
        
        let avgC = zip(pixA, pixB).map() { ($0 + $1) / 2 }
        
        return avgC
    }

    private func normalize(_ image: [Double]) -> [Double] {
        let mappedPixel = image.map() { (c) -> Double in
            let multPixel = c * constMultiplier
            return multPixel > 255 ? 255 : multPixel
        }
        return mappedPixel
    }
}

let arg1: [Double] = transformToArray(args[1])
let arg2: [Double] = transformToArray(args[2])

if arg1.count == arg2.count {
	let pixel = PixelAverage(pixA: arg1, pixB: arg2)
	print(pixel.normalizePixel())
	exit(0)
} else {
	print("Number of pixels don't match")
	exit(1)
}