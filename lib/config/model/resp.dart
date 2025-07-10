import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Resp {
  int? code;
  int? statusCode;
  dynamic error;
  String? status;
  dynamic statusMsg;
  dynamic errorData;
  dynamic success;
  dynamic data;
  dynamic message;
  dynamic token;
  dynamic user;
  dynamic en;
  dynamic hk;

  Resp(
      {this.error,
      this.code,
      this.statusCode,
      this.status,
      this.statusMsg,
      this.errorData,
      this.data,
      this.success,
        this.message,
        this.token,
        this.user,
        this.en,
        this.hk
      });


  factory Resp.fromJson(Map<String, dynamic> json) => Resp(
    code: json["code"],
    statusCode: json["statusCode"],
    error: json["error"],
    status: json["status"],
    statusMsg: json["statusMsg"],
    errorData: json["errorData"],
    success: json["success"],
    data: json["data"],
    message: json["message"],
    token: json["token"],
    user: json["user"],
    en: json["en"],
    hk: json["hk"]
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "statusCode": statusCode,
    "error": error,
    "status": status,
    "statusMsg": statusMsg,
    "errorData": errorData,
    "success": success,
    "data": data,
    "message": message,
    "token": token,
    "user": user,
    "en": en,
    "hk": hk
  };
}
