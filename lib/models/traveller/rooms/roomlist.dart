class RoomList {
  var numberOfPerson;

  final String id;

  RoomList({required this.id, required this.numberOfPerson});

  // Convert a RoooList object into a Map object
  RoomList copyWith({
    String? id,
    int? numberOfPerson,
  }) {
    return RoomList(
      id: id ?? this.id,
      numberOfPerson: numberOfPerson ?? this.numberOfPerson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'noOfRooms': numberOfPerson ?? 1,
    };
  }

  @override
  String toString() {
    return 'RoomList(id: $id, numberOfPerson: $numberOfPerson)';
  }

  // Convert a Map object into a RoooList object
  factory RoomList.fromMap(Map<String, dynamic> map) {
    return RoomList(
      id: map['id'],
      numberOfPerson: map['noOfRooms'],
    );
  }
}
