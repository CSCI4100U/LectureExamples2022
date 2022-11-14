class Person{
  int? id;
  String? name;

  Person({this.name, this.id});

  Person.fromMap(Map map){
    this.id = map['id'];
    this.name = map['name'];

  }

  //typing required!!
  Map<String, Object> toMap(){
    if (this.id == null){
      return {
        'name': this.name!
      };
    }
    return {
      'id': this.id!,
      'name': this.name!
    };
  }

  @override
  String toString(){
    return 'Person(id: $id, name: $name';
  }
}