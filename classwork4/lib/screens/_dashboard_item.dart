import 'package:flutter/material.dart';

class DashboardItem {
  final String title;
  final String subtitle;
  final Widget Function() builder;

  const DashboardItem({
    required this.title,
    required this.subtitle,
    required this.builder,
  });
}

