// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String userId;
  String firstName;
  String lastName;
  String email;
  String birthdate;
  String address;
  String city;
  String country;
  String avatar;

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthdate,
    required this.address,
    required this.city,
    required this.country,
    required this.avatar,
  });

  UserModel copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? birthdate,
    String? address,
    String? city,
    String? country,
    String? avatar,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      birthdate: birthdate ?? this.birthdate,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthdate': birthdate,
      'address': address,
      'city': city,
      'country': country,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] as String? ?? "",
      firstName: map['first_name'] as String? ?? "",
      lastName: map['last_name'] as String? ?? "",
      email: map['email'] as String? ?? "",
      birthdate: map['birthdate'] as String? ?? "",
      address: map['address'] as String? ?? "",
      city: map['city'] as String? ?? "",
      country: map['country'] as String? ?? "",
      avatar: map['avatar'] as String? ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, birthdate: $birthdate, address: $address, city: $city, country: $country, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.birthdate == birthdate &&
        other.address == address &&
        other.city == city &&
        other.country == country &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        birthdate.hashCode ^
        address.hashCode ^
        city.hashCode ^
        country.hashCode ^
        avatar.hashCode;
  }
}
