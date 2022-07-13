import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'model/model.dart';
import 'sample_browser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await updateControlItems();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SampleBrowser());
}
