class Token {
  late String _rollno;
  late String _accessToken;
  late String _refreshToken;

  Token(this._rollno, this._accessToken, this._refreshToken);
  //getter

  String get rollno => _rollno;
  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  // setter
  set rollno(String rollno) {
    this._rollno = rollno;
  }

  set accessToken(String accessToken) {
    this._accessToken = accessToken;
  }

  set refreshToken(String refreshToken) {
    this._refreshToken = refreshToken;
  }

  String toString() {
    return '''{
      rollno: $_rollno,
      acessToken: $_accessToken,
      refreshToken: $_refreshToken
    }''';
  }

  // Convert a Note object into Map Object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['rollno'] = _rollno;
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    return map;
  }

  static fromMapObject(Map<String, dynamic> map){
    return Token(
    map['rollno'],map['accessToken'],map['refreshToken']
    );
  }
}
