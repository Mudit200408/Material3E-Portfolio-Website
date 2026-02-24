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
      child: AnimatedShapeContainer(
        width: imageSize.r,
        height: imageSize.r,
        color: theme.colorScheme.primaryFixed,
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
      delay: 200.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: 'Hello, I am ',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontVariations: const [
                      FontVariation('wght', 350),
                      FontVariation('wdth', 50),
                      FontVariation('opsz', 19),
                      FontVariation('GRAD', 30),
                    ],
                    letterSpacing: 0.2.r,
                  ),
                ),
                TextSpan(
                  text: 'Mudit Purohit',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontVariations: const [
                      FontVariation('wght', 800),
                      FontVariation('slnt', -8),
                      FontVariation('GRAD', 80),
                      FontVariation('wdth', 20),
                      FontVariation('opsz', 23),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Cross Platform App Developer',
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontVariations: const [
                FontVariation('wght', 800),
                FontVariation('GRAD', 50),
                FontVariation('wdth', 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(BuildContext context, ThemeData theme) {
    return ScrollAnimatedFadeIn(
      delay: 400.ms,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
        margin: EdgeInsets.symmetric(
          horizontal: ResponsiveLayoutHelper.responsiveValue(
            context,
            mobile: 4.r,
            desktop: 16.r,
          ),
          vertical: 16.r,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixed.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: 'I am a skilled ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: AppConstants.introFontNormal,
                ),
              ),
              TextSpan(
                text: 'Flutter Developer',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontVariations: AppConstants.introFontEmphasized,
                ),
              ),
              TextSpan(
                text:
                    ' with expertise in building robust and scalable mobile applications. My experience includes using ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: AppConstants.introFontNormal,
                ),
              ),
              TextSpan(
                text: 'Clean Architecture ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontVariations: AppConstants.introFontEmphasized,
                ),
              ),
              TextSpan(
                text: 'and ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: AppConstants.introFontNormal,
                ),
              ),
              TextSpan(
                text: 'SOLID principles ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontVariations: AppConstants.introFontEmphasized,
                ),
              ),
              TextSpan(
                text: 'for clean, maintainable code. I\'m proficient in ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: AppConstants.introFontNormal,
                ),
              ),
              TextSpan(
                text: 'Dart',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontVariations: AppConstants.introFontEmphasized,
                ),
              ),
              TextSpan(
                text: ', and have integrated ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: AppConstants.introFontNormal,
                ),
              ),
              TextSpan(
                text: 'Firebase services ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontVariations: AppConstants.introFontEmphasized,
                ),
              ),
              TextSpan(
                text: 'and ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: AppConstants.introFontNormal,
                ),
              ),
              TextSpan(
                text: 'Gemini AI ',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontVariations: AppConstants.introFontEmphasized,
                ),
              ),
              TextSpan(
                text:
                    'to create dynamic and intelligent applications. I am passionate about creating innovative and efficient applications that provide a seamless user experience.',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontVariations: AppConstants.introFontNormal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
