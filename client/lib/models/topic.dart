class Topic {
  final int id;
  final int userId;
  final String subject;
  final bool isPublic;

  Topic(this.id, this.userId, this.subject, this.isPublic);

  Topic.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int,
      userId = json['userId'] as int,
      subject = json['subject'],
      isPublic = json['isPublic'] as bool;
  

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'userId' : id,
      'subject' : subject,
      'isPublic' : isPublic,
    };
  }
  @override
  String toString() {
    return 'id: $id, userId: $userId, subject: $subject}';
  }
}