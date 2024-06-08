import 'package:flutter/material.dart';

class PageNavigator {
  BuildContext? ctx;

  PageNavigator({
    this.ctx,
  });

  void nextPageOnly({Widget? page}) {
    Navigator.pushAndRemoveUntil(
      ctx!,
      MaterialPageRoute(
        builder: (context) => page!,
      ),
      (route) => false,
    );
  }

  void nextPage({Widget? page}) {
    Navigator.pushReplacement(
      ctx!,
      MaterialPageRoute(
        builder: (context) => page!,
      ),
    );
  }

  void pushPage({Widget? page}) {
    Navigator.push(
      ctx!,
      MaterialPageRoute(
        builder: (context) => page!,
      ),
    );
  }

  void popUp() {
    Navigator.pop(ctx!);
  }

  void popUpToRoot() {
    Navigator.popUntil(
      ctx!,
      (route) => route.isFirst,
    );
  }
}
