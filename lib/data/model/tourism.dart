class Tourism {
  final int id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final int like;
  final String image;
  Tourism({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.like,
    required this.image,
  });

  factory Tourism.fromJson(Map<String, dynamic> json) {
    return Tourism(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      like: json['like'],
      image: json['image'],
    );
  }
}