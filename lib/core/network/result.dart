// ignore: constant_identifier_names
enum Status { initial, loading, success, fail }

abstract class Result<T> {
  final Status status;

  const Result._(this.status);

  const factory Result.inital() = Initial<T>;

  const factory Result.success(T data) = Success<T>;

  const factory Result.loading() = Loading<T>;

  const factory Result.error(String error) = Fail<T>;
}

class Initial<T> extends Result<T> {
  const Initial() : super._(Status.initial);
}

class Fail<T> extends Result<T> {
  final String error;
  const Fail(this.error) : super._(Status.fail);
}

class Loading<T> extends Result<T> {
  const Loading() : super._(Status.loading);
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data) : super._(Status.success);
}
