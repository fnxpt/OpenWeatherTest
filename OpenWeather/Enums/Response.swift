enum Response<T> {
    case error(error: Error)
    case success(object: T)
}
