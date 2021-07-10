// Project imports:
import '../../utils/enums.dart';

class CustomException implements Exception {
  final dynamic _message;
  final String _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class InternetConnectionException extends CustomException {
  InternetConnectionException([String message])
      : super(message, "${exceptionPrefix.noInternet}: ");
}

class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "${exceptionPrefix.internalServerError}: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message])
      : super(message, "${exceptionPrefix.invalidRequest}: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message])
      : super(message, "${exceptionPrefix.unauthorised}: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message])
      : super(message, "${exceptionPrefix.invalidInput}: ");
}

class BadFormatException extends CustomException {
  BadFormatException([String message])
      : super(message, "${exceptionPrefix.badFormat}: ");
}

class FirebaseWeakPasswordException extends CustomException {
  FirebaseWeakPasswordException([String message])
      : super(message, "${exceptionPrefix.firebaseWeakPassword}: ");
}

class FirebaseEmailAlreadyInUseException extends CustomException {
  FirebaseEmailAlreadyInUseException([String message])
      : super(message, "${exceptionPrefix.firebaseEmailAlreadyInUse}: ");
}

class FirebaseNoUserFoundException extends CustomException {
  FirebaseNoUserFoundException([String message])
      : super(message, "${exceptionPrefix.firebaseNoUserFound}: ");
}

class FirebaseWrongPasswordException extends CustomException {
  FirebaseWrongPasswordException([String message])
      : super(message, "${exceptionPrefix.firebaseWrongPassword}: ");
}

class FirebaseInvalidEmailException extends CustomException {
  FirebaseInvalidEmailException([String message])
      : super(message, "${exceptionPrefix.fireBaseInvalidEmail}: ");
}

class FirebaseNetworkFailedException extends CustomException {
  FirebaseNetworkFailedException([String message])
      : super(message, "${exceptionPrefix.firebaseNetworkFailed}: ");
}

class GoogleSignInCancelledException extends CustomException {
  GoogleSignInCancelledException([String message])
      : super(message, "${exceptionPrefix.googleSignInCancelled}: ");
}


