class HainaResponse<T> {
  int code;
  String msg;
  T data;

  HainaResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory HainaResponse.fromJson(Map<String, dynamic> json) =>
      HainaResponse(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] as T,
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data,
  };
}
