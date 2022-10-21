class Todo{
  //Unique identifier in DB, and thing to do
  int? id;
  String? item;

  Todo({this.id, this.item});

  //Generates a new To Do object from a map
  //generally from the database we're using
  Todo.fromMap(Map map){
    this.id = map['id'];
    this.item = map['item'];
  }

  //The typing here is mandatory! If you do not
  //specify Map<String,Object?>, everything breaks
  Map<String,Object?> toMap(){
    return {
      'id': this.id,
      'item': this.item
    };
  }

  String toString(){
    return 'Todo[id: $id], item: $item';
  }
}