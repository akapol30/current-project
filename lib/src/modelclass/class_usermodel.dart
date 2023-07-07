class UserModel {
  final String id;
  final String name;
  final String email;
  final String image;
  
  final DateTime joined;
  

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.joined,
    
  });
}