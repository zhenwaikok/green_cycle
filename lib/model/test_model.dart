class DogImageResponse {
  String? message;
  String? status;

  DogImageResponse({this.message, this.status});

  factory DogImageResponse.fromJson(Map<String, dynamic> json) {
    return DogImageResponse(message: json['message'], status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'status': status};
  }
}
