import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? msg;

  const ServerException([this.msg]);
  
  @override
  List<Object?> get props => [msg];

  @override
  String toString() => "$msg";
}

class FetchDataException extends ServerException {
  const FetchDataException([msg]) : super("Error during communication");
}

class BadRequestException extends ServerException {
  const BadRequestException([msg]) : super("Bad Request");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([msg]) : super("Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException([msg]) : super("Request info not found");
}

class ConflictException extends ServerException {
  const ConflictException([msg]) : super("Conflict occured");
}

class InternalServerException extends ServerException {
  const InternalServerException([msg]) : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([msg]) : super("No Internet Connection");
}

class UnknownException extends ServerException {
  const UnknownException([msg]) : super("Unknown error $msg");
}

class CacheException implements Exception {}