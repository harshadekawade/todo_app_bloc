abstract class TodoEvents {}

class TodoInitialEvent extends TodoEvents {}

class TodoCompleteTaskEvent extends TodoEvents {
  int index;
  bool isCompleted;
  TodoCompleteTaskEvent(this.index, this.isCompleted);
}

class TodoAddTaskEvent extends TodoEvents {
  String taskName;
  TodoAddTaskEvent(this.taskName);
}

class TodoRemoveTaskEvent extends TodoEvents {
  int index;
  TodoRemoveTaskEvent(this.index);
}
