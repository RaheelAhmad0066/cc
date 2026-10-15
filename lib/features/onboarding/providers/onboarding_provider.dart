import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentStep = 0;
  final Set<String> _selectedInterests = {'suits_me', 'try_new', 'recreate'};
  String _selectedConfidence = 'beginner';

  int get currentStep => _currentStep;
  Set<String> get selectedInterests => _selectedInterests;
  String get selectedConfidence => _selectedConfidence;

  void setStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void toggleInterest(String id) {
    if (_selectedInterests.contains(id)) {
      _selectedInterests.remove(id);
    } else {
      _selectedInterests.add(id);
    }
    notifyListeners();
  }

  void setConfidence(String id) {
    _selectedConfidence = id;
    notifyListeners();
  }

  void nextStep(PageController controller) {
    if (_currentStep < 3) {
      _currentStep++;
      controller.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
      notifyListeners();
    }
  }

  void previousStep(PageController controller) {
    if (_currentStep > 0) {
      _currentStep--;
      controller.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
      notifyListeners();
    }
  }
}

