class UserProfile {
  final String name;
  final String city;
  final String about;
  final List<dynamic> passions;
  final String dob;
  final String image;
  final String gender;
  UserProfile({
    required this.name,
    required this.city,
    required this.about,
    required this.passions,
    required this.dob,
    required this.image,
    required this.gender
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final String _age = (DateTime.now().year - int.parse(json['dob'])).toString();
    return UserProfile(
      name: json['name'],
      city: json['city'],
      about: json['bio'],
      dob: _age,
      passions: json['passions'],
      image: json['image'],
      gender: json['gender']
    );
  }
}
