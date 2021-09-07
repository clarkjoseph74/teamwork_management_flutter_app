class TaskModel {
  String id;
  String name;
  String des;
  String writer;
  String writerId;
  String time;
  String deadline;
  bool isDone;
  TaskModel({
    required this.name,
    required this.id,
    required this.writerId,
    required this.des,
    required this.isDone,
    required this.time,
    required this.deadline,
    required this.writer,
  });

  toJson() {
    return {
      'name': name,
      'writerId': writerId,
      'id': id,
      'des': des,
      'writer': writer,
      'time': time,
      'deadline': deadline,
      'isDone': isDone
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
        name: map['name'],
        writerId: map['writerId'],
        id: map['id'],
        des: map['des'],
        isDone: map['isDone'],
        time: map['time'],
        deadline: map['deadline'],
        writer: map['writer']);
  }
}
