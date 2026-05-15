import 'my_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension MyAssetsExtension on MyAssets {
  Widget load({double? width, double? height, Color? color, BoxFit? fit}) {
    if (this is MyImages) {
      return Image.asset(
        path,
        width: width,
        height: height,
        color: color,
        fit: fit,
      );
    } else if (this is MySVGs) {
      return SvgPicture.asset(
        path,
        semanticsLabel: toString(),
        width: width,
        height: height,
        colorFilter:
            color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
        fit: fit ?? BoxFit.contain,
      );
    }else{
      return Text("Something Wrong");
    }
  }
}
