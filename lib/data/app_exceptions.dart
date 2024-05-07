// ignore_for_file: prefer_typing_uninitialized_variables

class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_message$_prefix';
  }
}

class InternetExpception extends AppExceptions {
  InternetExpception([String? message]) : super(message, 'No Internet');
}

class RequestTimeOut extends AppExceptions {
 RequestTimeOut([String? message]) : super(message, 'Request Time out');
}


class ServerException extends AppExceptions {
 ServerException([String? message]) : super(message, 'Internal Server Error');
}


class InvalidUrlExpection extends AppExceptions {
InvalidUrlExpection ([String? message]) : super(message, 'Invalid url Error');
}



class EmailExpection extends AppExceptions {
  EmailExpection ([String? message]) : super(message, '');
}


class FetchDataExpection extends AppExceptions {
 FetchDataExpection ([String? message]) : super(message, '');
}

