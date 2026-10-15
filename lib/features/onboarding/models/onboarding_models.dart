import 'package:flutter/material.dart';

class HelpInterest {
  final String id;
  final String title;
  final IconData icon;
  final String? imageAsset;

  const HelpInterest({
    required this.id,
    required this.title,
    required this.icon,
    this.imageAsset,
  });
}

class MakeupConfidenceLevel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String imageAsset;

  const MakeupConfidenceLevel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imageAsset,
  });
}
