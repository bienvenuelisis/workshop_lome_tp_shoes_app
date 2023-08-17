import 'package:flutter/widgets.dart';

import 'context.dart';

extension TextUtils on Text {
  Widget fitted(BuildContext context, [double widthPercent = 75]) {
    return FittedBox(
      child: SizedBox(
        width: context.width * (widthPercent / 100),
        child: this,
      ),
    );
  }

  Widget padTop(double top) {
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: this,
    );
  }

  Widget padTopAndBottom(double top, double bottom) {
    return Padding(
      padding: EdgeInsets.only(top: top, bottom: bottom),
      child: this,
    );
  }

  Widget rich(
    BuildContext context, {
    List<InlineSpan>? children,
    double widthPercent = 75,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextStyle? style,
    TextAlign textAlign = TextAlign.center,
  }) {
    return SizedBox(
      width: context.width * (widthPercent / 100),
      child: RichText(
        textAlign: textAlign,
        text: TextSpan(
          text: data,
          style: style ?? this.style,
          children: children,
        ),
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }

  Widget centered(BuildContext context) {
    return Center(
      child: this,
    );
  }

  Widget wrapped(BuildContext context) {
    return Wrap(
      children: [this],
    );
  }

  Widget padded(BuildContext context, [double padding = 10]) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget spaced(BuildContext context, [double spacing = 10]) {
    return SizedBox(
      width: spacing,
      child: this,
    );
  }

  Widget spacedVertically(BuildContext context, [double spacing = 10]) {
    return SizedBox(
      height: spacing,
      child: this,
    );
  }

  Widget spacedHorizontally(BuildContext context, [double spacing = 10]) {
    return SizedBox(
      width: spacing,
      child: this,
    );
  }
}
