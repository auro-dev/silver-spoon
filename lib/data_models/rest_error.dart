import 'dart:convert';

///
/// Created by Sunil Kumar from Boiler plate
///
RestError restErrorResponseFromJson(String str) =>
    RestError.fromJson(json.decode(str));

String restErrorResponseToJson(RestError data) => json.encode(data.toJson());

class RestError {
  String? name;
  String? message;
  int? code;
  String? className;
  bool? result;

  RestError({this.name, this.message, this.code, this.className, this.result});

  factory RestError.fromJson(Map<String, dynamic> json) => RestError(
      name: json["name"] ?? '',
      message: json["message"] ?? '',
      code: json["code"] ?? 0,
      className: json["className"] ?? '',
      result: json['result'] ?? false);
  @override
  String toString() => message ?? 'Some error occurred';

  Map<String, dynamic> toJson() => {
        "name": name,
        "message": message,
        "code": code,
        "className": className,
      };
}

class NoInternetError {
  @override
  String toString() => 'No internet connection';
}
