import 'package:flutter/material.dart';

extension SizeExtension on num{
  SizedBox get sizedBoxHeight => SizedBox(height: toDouble());

  SizedBox get sizedBoxWidth => SizedBox(width: toDouble());
}