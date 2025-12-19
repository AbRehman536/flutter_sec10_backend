
import 'package:flutter/material.dart';
import 'package:flutter_sec10_backend/views/create_task.dart';
import 'package:flutter_sec10_backend/views/get_all_priority.dart';
import 'package:flutter_sec10_backend/views/get_favorite.dart';
import 'package:flutter_sec10_backend/views/update_task.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../services/task.dart';
import 'get_completed.dart';
import 'get_incompleted.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetInCompletedTaskView(),
                ),
              );
            },
            icon: Icon(Icons.incomplete_circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetCompletedTaskView()),
              );
            },
            icon: Icon(Icons.circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetPriorityView()),
              );
            },
            icon: Icon(Icons.category),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetFavoriteTask()),
              );
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskView()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: taskList[i].isCompleted,
                      onChanged: (val) async {
                        try {
                          await TaskServices().markTaskAsComplete(
                              taskID: taskList[i].docId.toString(),
                              isCompleted: val!);
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          if (taskList[i].favUsers!.contains("1")) {
                            await TaskServices().removeToFavorite(
                              userID: "1",
                              taskID: taskList[i].docId.toString(),
                            );
                          } else {
                            await TaskServices().addToFavorite(
                              userID: "1",
                              taskID: taskList[i].docId.toString(),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(
                        taskList[i].favUsers!.contains("1")
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await TaskServices().deleteTask(taskList[i].docId.toString()).then((
                              val,
                              ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task has been deleted successfully",
                                ),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateTaskView(model: taskList[i]),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}