class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? priorityID;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.priorityID,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      docId: json["docID"],
      title: json["title"],
      description: json["description"],
      priorityID: json["priorityID"],
      isCompleted: json["isCompleted"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson(String taskID) {
    return {
      "docID": taskID,
      "title": title,
      "description": description,
     "priorityID": priorityID,
      "isCompleted": isCompleted,
      "createdAt": createdAt,
    };
  }
}