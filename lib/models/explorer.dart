class Explorer {
  final String name;
  final String city;
  final String dob;
  final String image;
  Explorer({
    required this.name,
    required this.city,
    required this.dob,
    required this.image,
   
  });
// int.parse(json['dob'])
  factory Explorer.fromJson(Map<String, dynamic> json) {
    final String _age = (DateTime.now().year - 2001).toString();
    return Explorer(
      name: json['name'],
      city: json['city'],
      dob: _age,
      image: json['image'],
    );
  }
}
