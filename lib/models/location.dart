class Location {
  final int id;
  final String title;
  final String city;
  final String state;
  final String address;
  final String img;
  final String tel;
  final String content;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    required this.title,
    required this.city,
    required this.state,
    required this.address,
    required this.img,
    required this.tel,
    required this.content,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      title: json['title'],
      city: json['city'],
      state: json['state'],
      address: json['address'],
      img: json['img'],
      tel: json['tel'],
      content: json['content'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
