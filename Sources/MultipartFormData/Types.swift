import Foundation

public typealias HTTPHeaders = [String: String]

public enum MultipartFormDataError: Error {
  case bodyPartURLInvalid(url: URL)
  case bodyPartFilenameInvalid(in: URL)
  case bodyPartFileNotReachable(at: URL)
  case bodyPartFileNotReachableWithError(atURL: URL, error: any Error)
  case bodyPartFileIsDirectory(at: URL)
  case bodyPartFileSizeNotAvailable(at: URL)
  case bodyPartFileSizeQueryFailedWithError(forURL: URL, error: any Error)
  case bodyPartInputStreamCreationFailed(for: URL)
  case outputStreamFileAlreadyExists(at: URL)
  case outputStreamURLInvalid(url: URL)
  case outputStreamCreationFailed(for: URL)
  case inputStreamReadFailed(error: any Error)
  case outputStreamWriteFailed(error: any Error)

  public struct UnexpectedInputStreamLength: Error {
    public let bytesExpected: UInt64
    public let bytesRead: UInt64
  }

  public var underlyingError: (any Error)? {
    switch self {
    case let .bodyPartFileNotReachableWithError(_, error),
      let .bodyPartFileSizeQueryFailedWithError(_, error),
      let .inputStreamReadFailed(error),
      let .outputStreamWriteFailed(error):
      return error

    case .bodyPartURLInvalid,
      .bodyPartFilenameInvalid,
      .bodyPartFileNotReachable,
      .bodyPartFileIsDirectory,
      .bodyPartFileSizeNotAvailable,
      .bodyPartInputStreamCreationFailed,
      .outputStreamFileAlreadyExists,
      .outputStreamURLInvalid,
      .outputStreamCreationFailed:
      return nil
    }
  }

  public var url: URL? {
    switch self {
    case let .bodyPartURLInvalid(url),
      let .bodyPartFilenameInvalid(url),
      let .bodyPartFileNotReachable(url),
      let .bodyPartFileNotReachableWithError(url, _),
      let .bodyPartFileIsDirectory(url),
      let .bodyPartFileSizeNotAvailable(url),
      let .bodyPartFileSizeQueryFailedWithError(url, _),
      let .bodyPartInputStreamCreationFailed(url),
      let .outputStreamFileAlreadyExists(url),
      let .outputStreamURLInvalid(url),
      let .outputStreamCreationFailed(url):
      return url

    case .inputStreamReadFailed, .outputStreamWriteFailed:
      return nil
    }
  }
}
