class UserInfo {
  final int id;
  final String username;
  final String email;
  final List<String> roles;

  UserInfo(this.id, this.username, this.email, this.roles);

  UserInfo.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      email = json['email'],
      id = json['id'] as int,
      roles = [...json['roles']];
  

  Map<String, dynamic> toJson() {
    return {
      'username' : username,
      'email' : email,
      'id' : id,
      'roles' : roles,
    };
  }
  @override
  String toString() {
    return 'id: $id, username: $username, email: $email, roles: ${roles.toString()}';
  }
}