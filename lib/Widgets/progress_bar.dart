import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 18),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.amber),
    ),
  );
}

linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 18),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.amber),
    ),
  );
}
