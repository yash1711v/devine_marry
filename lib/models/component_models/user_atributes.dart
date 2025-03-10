import 'dart:convert';

class DataModel {
  final List<MaritalStatus> maritalStatuses;
  final List<Gender> genders;

  DataModel({required this.maritalStatuses, required this.genders});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      maritalStatuses: (json['maritalStatuses'] as List?)
          ?.map((e) => MaritalStatus.fromJson(e))
          .toList() ??
          [],
      genders: (json['gender'] as List?)
          ?.map((e) => Gender.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maritalStatuses': maritalStatuses.map((e) => e.toJson()).toList(),
      'gender': genders.map((e) => e.toJson()).toList(),
    };
  }
}

class MaritalStatus {
  final int id;
  final String title;

  MaritalStatus({required this.id, required this.title});

  factory MaritalStatus.fromJson(Map<String, dynamic> json) {
    return MaritalStatus(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}

class Gender {
  final int id;
  final String gender;

  Gender({required this.id, required this.gender});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: (json['id'] as num?)?.toInt() ?? 0,
      gender: json['gender']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gender': gender,
    };
  }
}


class LookingFor {
  final int id;
  final String title;

  LookingFor({required this.id, required this.title});

  factory LookingFor.fromJson(Map<String, dynamic> json) {
    return LookingFor(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
