import 'package:equatable/equatable.dart';

class DemoUserModel extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String companyName;

  const DemoUserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.companyName,
  });

  factory DemoUserModel.fromJson(Map<String, dynamic> json) {
    return DemoUserModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      website: json['website'] as String? ?? '',
      companyName: (json['company'] as Map<String, dynamic>?)?['name'] as String? ??
          'Independent',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'phone': phone,
        'website': website,
        'company': {'name': companyName},
      };

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        phone,
        website,
        companyName,
      ];
}

class DemoModel extends Equatable {
  final int totalCount;
  final List<DemoUserModel> users;

  const DemoModel({
    required this.totalCount,
    required this.users,
  });

  factory DemoModel.fromJson(Map<String, dynamic> json) {
    final rawList = json['users'] as List<dynamic>? ?? [];
    final userList = rawList
        .whereType<Map<String, dynamic>>()
        .map(DemoUserModel.fromJson)
        .toList();

    return DemoModel(
      totalCount: json['totalCount'] as int? ??
          (json['totalClients'] as int? ?? userList.length),
      users: userList,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalCount': totalCount,
        'users': users.map((u) => u.toJson()).toList(),
      };

  @override
  List<Object?> get props => [totalCount, users];
}
