class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? priorityID;
  final List<String>? favUsers;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.priorityID,
    this.favUsers,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      docId: json["docID"],
      title: json["title"],
      description: json["description"],
      priorityID: json["priorityID"],
      favUsers: json["favUsers"] == null
          ? []
          : List<String>.from(json["favUsers"]!.map((x) => x)),
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
      "favUsers": favUsers == null
          ? []
          : List<dynamic>.from(favUsers!.map((x) => x)),
      "isCompleted": isCompleted,
      "createdAt": createdAt,
    };
  }
}