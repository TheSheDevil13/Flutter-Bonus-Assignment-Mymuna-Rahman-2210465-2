import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ui_class/models/task_model.dart';

class TaskRepository {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(TaskModel task) async {
    await _tasksCollection.doc(task.id).set(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }

  Stream<List<TaskModel>> fetchTasks() {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
