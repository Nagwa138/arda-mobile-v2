class OccupiedTime {
  final String start;
  final String end;

  OccupiedTime({required this.start, required this.end});

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}

class RoomPartner {
  var roomNo;
  var price;
  final List<OccupiedTime> occupiedTimes;

  RoomPartner({required this.roomNo,  this.price, required this.occupiedTimes});

  Map<String, dynamic> toJson() {
    return {
      'roomNo': roomNo,
      'price': price,
      'occupiedTimes': occupiedTimes.map((e) => e.toJson()).toList(),
    };
  }
}
