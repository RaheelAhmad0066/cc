import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentStep = 0;
  final Set<String> _selectedInterests = {'suits_me', 'try_new', 'recreate'};
  final Set<String> _selectedStyles = {'natural', 'romantic'};
  final Set<String> _selectedOccasions = {'everyday', 'night_out'};
  final Set<String> _selectedProductPreferences = {
    'budget',
    'cruelty_free',
    'long_wearing',
    'easy_apply',
  };
  String _selectedConfidence = 'beginner';

  int get currentStep => _currentStep;
  Set<String> get selectedInterests => _selectedInterests;
  Set<String> get selectedStyles => _selectedStyles;
  Set<String> get selectedOccasions => _selectedOccasions;
  Set<String> get selectedProductPreferences => _selectedProductPreferences;
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

  void toggleStyle(String id) {
    _toggleSelection(_selectedStyles, id);
  }

  void toggleOccasion(String id) {
    _toggleSelection(_selectedOccasions, id);
  }

  void toggleProductPreference(String id) {
    _toggleSelection(_selectedProductPreferences, id);
  }

  void _toggleSelection(Set<String> selections, String id) {
    if (!selections.add(id)) {
      selections.remove(id);
    }
    notifyListeners();
  }

  void setConfidence(String id) {
    _selectedConfidence = id;
    notifyListeners();
  }

  void nextStep(PageController controller) {
    if (_currentStep < 7) {
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
