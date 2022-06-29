//
//  WCStringStreamReader.swift
//  HelloString
//
//  Created by wesley_chen on 2022/6/27.
//

// @see https://stackoverflow.com/a/24065534
#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("Unknown platform")
#endif

/**
 A  reader for reading text file by stream style
 
 @see https://stackoverflow.com/a/24648951
 */
class WCStringStreamReader: NSObject {
    /**
     The number of lines which increased by nextLine func
     */
    public var numberOfLines: UInt
    
    private let encoding : String.Encoding
    private let chunkSize : Int
    private var fileHandle : FileHandle!
    private let delimData : Data
    private var buffer : Data
    private var atEof : Bool
    
    public init?(path: String, delimiter: String = "\n", encoding: String.Encoding = .utf8,
          chunkSize: Int = 4096) {

        guard let fileHandle = FileHandle(forReadingAtPath: path),
              let delimData = delimiter.data(using: encoding) else {
            return nil
        }
        self.encoding = encoding
        self.chunkSize = chunkSize
        self.fileHandle = fileHandle
        self.delimData = delimData
        self.buffer = Data(capacity: chunkSize)
        self.atEof = false
        self.numberOfLines = 0
    }

    deinit {
        self.close()
    }

    /// Return next line, or nil on EOF.
    /// @note This method will increase numberOfLines
    public func nextLine() -> String? {
        precondition(fileHandle != nil, "Attempt to read from closed file")

        // Read data chunks from file until a line delimiter is found:
        while !atEof {
            if let range = buffer.range(of: delimData) {
                // Convert complete line (excluding the delimiter) to a string:
                let line = String(data: buffer.subdata(in: 0..<range.lowerBound), encoding: encoding)
                // Remove line (and the delimiter) from the buffer:
                buffer.removeSubrange(0..<range.upperBound)
                numberOfLines += 1
                return line
            }
            let tmpData = fileHandle.readData(ofLength: chunkSize)
            if tmpData.count > 0 {
                buffer.append(tmpData)
            } else {
                // EOF or read error.
                atEof = true
                if buffer.count > 0 {
                    // Buffer contains last line in file (not terminated by delimiter).
                    let line = String(data: buffer as Data, encoding: encoding)
                    buffer.count = 0
                    numberOfLines += 1
                    return line
                }
            }
        }
        
        return nil
    }

    /// Start reading from the beginning of file.
    public func rewind() -> Void {
        fileHandle.seek(toFileOffset: 0)
        buffer.count = 0
        atEof = false
        numberOfLines = 0
    }

    /// Close the underlying file. No reading must be done after calling this method.
    public func close() -> Void {
        fileHandle?.closeFile()
        fileHandle = nil
    }
}

extension WCStringStreamReader : Sequence {
    func makeIterator() -> AnyIterator<String> {
        return AnyIterator {
            return self.nextLine()
        }
    }
}
