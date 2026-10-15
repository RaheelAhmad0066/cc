import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../core/constants/app_constants.dart';

class SplashProvider extends ChangeNotifier {
  bool _isInitialized = false;
  double _progress = 0.0;
  String _statusMessage = 'Initializing application...';

  bool get isInitialized => _isInitialized;
  double get progress => _progress;
  String get statusMessage => _statusMessage;

  /// Initializes essential app services, checks user session, etc.
  Future<void> initializeApp({required VoidCallback onComplete}) async {
    _statusMessage = 'Loading beauty catalog...';
    _progress = 0.3;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    _statusMessage = 'Preparing luxury styles...';
    _progress = 0.7;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 900));

    _statusMessage = 'Welcome to Enigma';
    _progress = 1.0;
    _isInitialized = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    onComplete();
  }
}

