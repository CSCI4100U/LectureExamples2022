class Todo{
  int? id; //unique identifier for the object
  int? userId; //person who owns this object
  String? title;
  bool? completed;

  Todo({this.title, this.completed, this.id, this.userId});
  
  factory Todo.fromMap(Map map){
    return Todo(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      completed: map['completed'],
    );
  }

  String toString(){
    return 'Todo($id, $userId, $title, $completed)';
  }
}