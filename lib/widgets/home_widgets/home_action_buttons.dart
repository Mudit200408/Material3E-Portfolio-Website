import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/core/utils/app_constants.dart';
import 'package:portfolio_web/core/utils/navigation_provider.dart';
import 'package:portfolio_web/models/nav_section_enums.dart';
import 'package:portfolio_web/widgets/gradient_button.dart';
import 'package:portfolio_web/widgets/outlined_button.dart';
import 'package:portfolio_web/widgets/resume_viewer_modal.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class HomeActionButtons extends StatefulWidget {
  final bool isMobile;

  const HomeActionButtons({super.key, required this.isMobile});

  @override
  State<HomeActionButtons> createState() => _HomeActionButtonsState();
}

class _HomeActionButtonsState extends State<HomeActionButtons> {
  bool isLoading = false;

  void _openResumeModal() async {
    HapticFeedback.lightImpact();
    setState(() => isLoading = true);

    final url = AppConstants.resumeUrl;

    setState(() => isLoading = false);

    if (url.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume URL not configured')),
      );
      return;
    }

    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ResumeViewerModal(resumeUrl: url),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = context.read<NavigationProvider>();

    return ScrollAnimatedFadeIn(
      key: const ValueKey('home_action_buttons'),
      delay: 800.ms,
      child: Flex(
        direction: widget.isMobile ? Axis.vertical : Axis.horizontal,
        spacing: 8.r,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomOutlinedButton(
            buttonName: isLoading ? "Loading..." : "View Resume",
            onPressed: _openResumeModal,
          ),
          GradientButton(
            buttonName: 'Get in Touch',
            onPressed: () => navProvider.scrollToSection(NavSection.contact),
          ),
        ],
      ),
    );
  }
}
