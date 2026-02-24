import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_web/models/nav_section_enums.dart';

class NavigationProvider extends ChangeNotifier {
  NavSection _currentSection = NavSection.home;
  bool _isProgrammaticScroll = false;
  final ScrollController _scrollController = ScrollController();

  final Map<NavSection, GlobalKey> sectionKeys = {
    NavSection.home: GlobalKey(),
    NavSection.about: GlobalKey(),
    NavSection.projects: GlobalKey(),
    NavSection.experience: GlobalKey(),
    NavSection.contact: GlobalKey(),
  };

  NavSection get currentSection => _currentSection;
  bool get isProgrammaticScroll => _isProgrammaticScroll;
  ScrollController get scrollController => _scrollController;

  NavigationProvider() {
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void setProgrammaticScroll(bool value) {
    if (_isProgrammaticScroll != value) {
      _isProgrammaticScroll = value;
      notifyListeners(); // or just update it, maybe no need to notify for this
    }
  }

  void _onScroll() {
    if (_isProgrammaticScroll) return;

    BuildContext? anyContext;
    for (final key in sectionKeys.values) {
      if (key.currentContext != null) {
        anyContext = key.currentContext;
        break;
      }
    }
    if (anyContext == null) return;

    final screenHeight = MediaQuery.of(anyContext).size.height;
    final triggerLine = screenHeight / 3;

    NavSection activeSection = _currentSection;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 1.0) {
      activeSection = NavSection.values.last;
    } else {
      for (final section in NavSection.values.reversed) {
        final key = sectionKeys[section];
        final context = key?.currentContext;

        if (context != null) {
          final box = context.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero).dy;

          if (position <= triggerLine) {
            activeSection = section;
            break;
          }
        }
      }
    }

    if (_currentSection != activeSection) {
      _currentSection = activeSection;
      notifyListeners();
    }
  }

  Future<void> scrollToSection(NavSection section) async {
    HapticFeedback.lightImpact();
    // Update state immediately
    _currentSection = section;
    notifyListeners();

    final key = sectionKeys[section];
    final context = key?.currentContext;

    if (context != null) {
      _isProgrammaticScroll = true;

      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );

      _isProgrammaticScroll = false;
    }
  }
}
