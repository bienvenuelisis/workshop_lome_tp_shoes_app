import 'package:flutter/material.dart';

extension BuildContextEnhanced on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  bool get isXLarge => width > 1200;

  bool get isLarge => width > 600;

  bool get isMedium => width > 400 && width < 600;

  bool get isSmall => width < 400;

  bool get isXSmall => width < 800;

  bool get isPortrait => size.width < size.height;

  bool get isLandscape => size.width > size.height;

  ThemeData get theme => Theme.of(this);

  ///Pop the current page.
  void pop<T extends Object?>() {
    return Navigator.pop(this);
  }

  ///Navigate to a new page.
  ///
  ///[page] - The new page.
  Future<T?> pushTo<T extends Object?>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  ///Navigate to a new page and then disposing the current page.
  ///
  ///[page] - The new page.
  Future<T?> replaceWith<T extends Object?, TO extends Object?>(
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  ///Navigate to a new page and then disposing all previous pages.
  ///
  ///[page] - The new page, ie the new first page in the stack.
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (Route<dynamic> route) => predicate == null ? false : predicate(route),
    );
  }

  ///Open a dialog.
  ///
  ///[title] - The dialog title.
  ///[content] - The dialog content.
  ///[cancelText] - The dialog cancel text.
  ///[okText] - The dialog ok text.
  ///[okFunc] - The dialog ok function.
  Future dialog<T>({
    required String title,
    required String content,
    String cancelText = "Annuler",
    String okText = "OK",
    VoidCallback? cancelFunc,
    VoidCallback? okFunc,
  }) async {
    return await showDialog<T>(
      context: this,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, cancelText);
              if (cancelFunc != null) cancelFunc();
            },
            child: Text(
              cancelText,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, okText);
              if (okFunc != null) okFunc();
            },
            child: Text(okText),
          ),
        ],
      ),
    );
  }

  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }

  void snackbar(
    String message, {
    int duration = 3,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    void Function()? action,
    String actionText = "Ok",
    Widget? leading,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: behavior,
        content: leading == null
            ? Text(message)
            : Row(
                children: [
                  leading,
                  const SizedBox(width: 20),
                  Expanded(child: Text(message)),
                ],
              ),
        duration: Duration(seconds: duration),
        action: action == null
            ? null
            : SnackBarAction(
                label: actionText,
                onPressed: action,
              ),
      ),
    );
  }
}
