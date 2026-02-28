import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_web/core/responsive/responsive_layout_helper.dart';
import 'package:portfolio_web/core/utils/app_constants.dart';
import 'package:portfolio_web/widgets/animated_shape_container.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class HomeHeroSection extends StatelessWidget {
  final ThemeData theme;

  const HomeHeroSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileSection(context, theme),
        SizedBox(height: 32.h),
        _buildIntroText(context, theme),
        SizedBox(height: 16.h),
        _buildInfoBox(context, theme),
      ],
    );
  }

  Widget _buildProfileSection(BuildContext context, ThemeData theme) {
    final imageSize = ResponsiveLayoutHelper.responsiveValue(
      context,
      mobile: 200.0,
      tablet: 250.0,
      desktop: 300.0,
    );

    return ScrollAnimatedFadeIn(
      key: const ValueKey('home_profile_image'),
      child: AnimatedShapeContainer(
        width: imageSize.r,
        height: imageSize.r,
        color: theme.colorScheme.primaryContainer,
        border: BorderSide(
          color: theme.colorScheme.onPrimaryContainer,
          width: 2,
        ),
        child: Image.network(AppConstants.profileUrl),
      ),
    );
  }

  Widget _buildIntroText(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      key: const ValueKey('home_intro_text'),
      delay: 200.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hi there! I\'m  ', // More casual greeting
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontVariations: const [
                      FontVariation(
                        'wght',
                        300,
                      ), // Slightly lighter for contrast
                    ],
                  ),
                ),
                TextSpan(
                  text: 'Mudit',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontVariations: const [
                      FontVariation('wght', 900),
                      FontVariation('GRAD', 80),
                      FontVariation('XOPQ', 125),
                      FontVariation('XTRA', 468),
                      FontVariation('opsz', 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Crafting high-performance mobile experiences.',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.tertiary,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      key: const ValueKey('home_info_box'),
      delay: 400.ms,
      child: Container(
        padding: EdgeInsets.all(24.r), // Increased padding for M3 feel
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveLayoutHelper.responsiveValue(
            context,
            mobile: 6.w,
            desktop: 20.w,
          ),
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(
            28.r,
          ), // More rounded for M3 Expressive
        ),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              height: 1.6,
            ),
            children: [
              const TextSpan(text: 'I\'m a '),
              TextSpan(
                text: 'Flutter Developer ',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontVariations: const [FontVariation('wght', 700)],
                ),
              ),
              const TextSpan(text: 'on a mission to build '),
              TextSpan(
                text: 'production-ready apps ',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontVariations: const [FontVariation('wght', 700)],
                ),
              ),
              const TextSpan(
                text:
                    'that actually scale. I don\'t just write code; I obsess over ',
              ),
              TextSpan(
                text: 'Clean Architecture ',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontVariations: const [FontVariation('wght', 700)],
                ),
              ),
              const TextSpan(text: 'and '),
              TextSpan(
                text: 'SOLID principles ',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontVariations: const [FontVariation('wght', 700)],
                ),
              ),
              const TextSpan(
                text: 'to ensure everything I build is resilient. ',
              ),
              const TextSpan(text: 'Currently, I’m '),
              TextSpan(
                text: 'refining my Flutter craft ',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontVariations: const [FontVariation('wght', 700)],
                ),
              ),
              const TextSpan(text: 'and exploring the intersection of '),
              TextSpan(
                text: 'AI & Cloud Systems. ',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontVariations: const [FontVariation('wght', 700)],
                ),
              ),
              const TextSpan(
                text:
                    'I’m looking for opportunities to build production-scale apps with a team that values clean code as much as I do.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
