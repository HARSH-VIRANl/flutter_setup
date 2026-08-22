import 'package:flutter/material.dart';

extension SizedBoxExtension on double {
  SizedBox get heightBox {
    return SizedBox(
      height: this,
    );
  }

  SizedBox get widthBox {
    return SizedBox(
      width: this,
    );
  }
}

extension OnClickExtension on Widget {
  Widget onClick(void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}
