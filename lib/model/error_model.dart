class ErrorModel {
  int? statusCode;
  String? message;

  ErrorModel({this.statusCode, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = int.tryParse(json['status'].toString()) ?? 0;
    final msg = json['message'];
    if (msg is List) {
      message = msg.map((e) => e.toString()).join('\n');
    } else if (msg != null) {
      message = msg.toString();
    } else {
      message = 'Unknown error occurred';
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = statusCode;
    data['message'] = message;
    return data;
  }
}
