
import 'package:flutter/material.dart';
import 'package:flutter_sec10_backend/models/priority.dart';
import 'package:flutter_sec10_backend/views/create_priority.dart';
import 'package:provider/provider.dart';

import '../services/priority.dart';

class GetPriorityView extends StatelessWidget {
  const GetPriorityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get All Priorities")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePriority(model: PriorityModel(), isUpdateMode: false,)),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PriorityModel()],
        builder: (context, child) {
          List<PriorityModel> priorityList = context
              .watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.category),
                title: Text(priorityList[i].name.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          await PriorityServices()
                              .deletePriority(priorityList[i])
                              .then((val) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                    "Priority has been deleted successfully",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Okay"),
                                    ),
                                  ],
                                );
                              },
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
                                CreatePriority(model: priorityList[i], isUpdateMode: true,),
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