class PostModel {
  final String email;
  final String message;
  final String date;

  PostModel({
    required this.email,
    required this.message,
    required this.date,
  });

  factory PostModel.fromJson(jsonData) {
    return PostModel(
      email: jsonData['email'],
      message: jsonData['message'],
      date: jsonData['date'],
    );
  }
}
