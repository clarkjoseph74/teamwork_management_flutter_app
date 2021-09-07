import 'dart:convert';

class CommentModel {
  String userName;
  String userImage;
  String comment;
  String userPosition;
  String time;
  CommentModel({
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.userPosition,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userImage': userImage,
      'comment': comment,
      'userPosition': userPosition,
      'time': time,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userName: map['userName'],
      userImage: map['userImage'],
      comment: map['comment'],
      userPosition: map['userPosition'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));
}
