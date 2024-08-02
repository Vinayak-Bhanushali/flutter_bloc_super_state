// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  @override
  String toString() {
    return 'User(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, avatar: $avatar)';
  }
}
