
import 'package:flutter/material.dart';
import 'package:flutter_sec10_backend/views/create_task.dart';
import 'package:flutter_sec10_backend/views/get_all_priority.dart';
import 'package:flutter_sec10_backend/views/get_favorite.dart';
import 'package:flutter_sec10_backend/views/update_task.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../provider/user.dart';
import '../services/task.dart';
import 'get_completed.dart';
import 'get_incompleted.dart';

class GetFavorite extends StatelessWidget {
  const GetFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Get Favorite Task"),

      ),

      body: StreamProvider.value(
        value: TaskServices().getAllFavorite(userProvider.getUser().docId.toString()),
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
              );
            },
          );
        },
      ),
    );
  }
}