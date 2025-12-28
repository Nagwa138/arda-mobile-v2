enum UserType {
  traveller(0, 'Traveller'),
  partner(1, 'Partner'),
  admin(2, 'Admin'),
  accommodation(3, 'Accommodation'),
  activity(4, 'Activity'),
  trip(5, 'Trip'),
  product(6, 'Product');

  const UserType(this.id, this.displayName);

  final int id;
  final String displayName;

  static UserType fromId(int id) {
    return UserType.values.firstWhere((type) => type.id == id);
  }

  bool get isPartnerType =>
      [accommodation, activity, trip, product].contains(this);

  String get partnerTypeKey {
    switch (this) {
      case UserType.accommodation:
        return 'accommodation';
      case UserType.activity:
        return 'activity';
      case UserType.trip:
        return 'trip';
      case UserType.product:
        return 'product';
      default:
        throw ArgumentError('$this is not a partner type');
    }
  }
}
