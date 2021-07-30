import 'package:flutter/cupertino.dart';

class AppThemeData {
  const AppThemeData({
    required this.name,
    required this.backgroundColors,
    required this.primaryColor,
    required this.secondaryColor,
    required this.cardColor,
    required this.statusBarColor,
    required this.navBarColor,
  });

  final String name;
  final List<int> backgroundColors;
  final int primaryColor;
  final int secondaryColor;
  final int cardColor;
  final int statusBarColor;
  final int navBarColor;

  @override
  List<Object?> get props => [
        name,
        backgroundColors,
        primaryColor,
        secondaryColor,
        cardColor,
        statusBarColor,
        navBarColor,
      ];

  AppThemeData fromJson(Map<String, dynamic> json) {
    return AppThemeData(
      name: json['name'] as String,
      backgroundColors: (json['backgroundColors'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      primaryColor: json['primaryColor'] as int,
      secondaryColor: json['secondaryColor'] as int,
      cardColor: json['cardColor'] as int,
      statusBarColor: json['statusBarColor'] as int,
      navBarColor: json['navBarColor'] as int,
    );
  }

  Map<String, dynamic> toJson(AppThemeData instance) => <String, dynamic>{
        'name': instance.name,
        'backgroundColors': instance.backgroundColors,
        'primaryColor': instance.primaryColor,
        'secondaryColor': instance.secondaryColor,
        'cardColor': instance.cardColor,
        'statusBarColor': instance.statusBarColor,
        'navBarColor': instance.navBarColor,
      };

  AppThemeData copyWith({
    String? name,
    List<int>? backgroundColors,
    int? primaryColor,
    int? secondaryColor,
    int? cardColor,
    int? statusBarColor,
    int? navBarColor,
  }) {
    return AppThemeData(
      name: name ?? this.name,
      backgroundColors: backgroundColors ?? this.backgroundColors,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      cardColor: cardColor ?? this.cardColor,
      statusBarColor: statusBarColor ?? this.statusBarColor,
      navBarColor: navBarColor ?? this.navBarColor,
    );
  }
}

const predefinedThemes = [
  gin,
];
const color = Color(0xffeaeaea);

const AppThemeData gin = AppThemeData(
  name: 'gin',
  backgroundColors: [0xff4a81ec],
  primaryColor: 0xff4a81ec,
  secondaryColor: 0xff4b8bfd,
  cardColor: 0xfffafafa,
  statusBarColor: 0xff4a81ec,
  navBarColor: 0xff4a81ec,
);
