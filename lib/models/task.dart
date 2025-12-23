class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? priorityID;
  final String? userID;
  final List<String>? favUsers;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.priorityID,
    this.userID,
    this.favUsers,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      docId: json["docID"],
      title: json["title"],
      userID: json["userID"],
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
      "userID": userID,
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