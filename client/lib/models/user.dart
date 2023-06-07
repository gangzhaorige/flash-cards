class User {
  final String username;
  final String email;
  final int id;
  
  User(this.username,this.email,this.id);

  User.fromJson(Map<String, dynamic> json) 
    : username = json['username'],
      email = json['email'],
      id = json['id'] as int;
  
  Map<String, dynamic> toJson() {
    return {
      'username' : username,
      'email' : email,
      'id' : id
    };
  }
}