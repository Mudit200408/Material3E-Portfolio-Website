import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:portfolio_web/core/loader/loader.dart';
import 'package:portfolio_web/core/utils/app_constants.dart';
import 'package:portfolio_web/core/utils/url_launcher_helper.dart';
import 'package:portfolio_web/widgets/scroll_animated_fade_in.dart';
import 'package:portfolio_web/widgets/social_button.dart';
import 'package:responsive_scaler/responsive_scaler.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    HapticFeedback.lightImpact();
    if (mounted) UrlLauncherHelper.launch(context, url);
  }

  Future<void> _sendEmail() async {
    HapticFeedback.lightImpact();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      try {
        final response = await http.post(
          Uri.parse('https://api.web3forms.com/submit'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'access_key': AppConstants.web3FormsKey,
            'name': _nameController.text,
            'email': _emailController.text,
            'subject': _subjectController.text,
            'message': _messageController.text,
          }),
        );

        if (mounted) {
          final theme = Theme.of(context);
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    M3EContainer.c9SidedCookie(
                      color: theme.colorScheme.onPrimaryFixed,
                      padding: EdgeInsets.all(12.r),
                      margin: EdgeInsets.only(right: 8.r),
                      child: Icon(
                        Icons.check_rounded,
                        color: theme.colorScheme.primaryFixed,
                      ),
                    ),
                    Text(
                      'Message sent successfully!',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryFixed,
                      ),
                    ),
                  ],
                ),
                backgroundColor: theme.colorScheme.primaryFixed,
              ),
            );
            _nameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    M3EContainer.sunny(
                      color: theme.colorScheme.onErrorContainer,
                      padding: EdgeInsets.all(12.r),
                      margin: EdgeInsets.only(right: 8.r),
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: theme.colorScheme.errorContainer,
                      ),
                    ),
                    Text(
                      'Failed to send message: test error',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                  ],
                ),
                backgroundColor: theme.colorScheme.errorContainer,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          final theme = Theme.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  M3EContainer.sunny(
                    color: theme.colorScheme.onErrorContainer,
                    padding: EdgeInsets.all(12.r),
                    margin: EdgeInsets.only(right: 8.r),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: theme.colorScheme.errorContainer,
                    ),
                  ),
                  Text(
                    'Failed to send message: $e',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ],
              ),
              backgroundColor: theme.colorScheme.errorContainer,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSending = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 24.r,
        right: 24.r,
        top: 85.r,
        bottom: 32.r,
      ),
      child: Column(
        children: [
          ScrollAnimatedFadeIn(
            key: const ValueKey('contact_header'),
            child: Text(
              'Get in Touch',
              style: theme.textTheme.displaySmall?.copyWith(
                fontVariations: AppConstants.headingFont,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          ScrollAnimatedFadeIn(
            key: const ValueKey('contact_subtitle'),
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Feel free to reach out for collaborations or just a friendly hello',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32.h),

          // Social Buttons
          ScrollAnimatedFadeIn(
            key: const ValueKey('contact_form'),
            delay: const Duration(milliseconds: 300),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16.r,
              runSpacing: 6.r,
              children: [
                // Phone
                SocialButton(
                  iconPath: 'assets/icons/phone.svg',
                  onPressed: () => _launchUrl(AppConstants.phoneUrl),
                  tooltip: 'Phone Call',
                ),

                // Whatsapp
                SocialButton(
                  iconPath: 'assets/icons/whatsapp.svg',
                  onPressed: () => _launchUrl(AppConstants.whatsappUrl),
                  tooltip: 'Whatsapp',
                ),

                // Email
                SocialButton(
                  iconPath: 'assets/icons/email.svg',
                  onPressed: () => _launchUrl('mailto:${AppConstants.email}'),
                  tooltip: 'Email',
                ),

                // Telegram
                SocialButton(
                  iconPath: 'assets/icons/telegram.svg',
                  onPressed: () => _launchUrl(AppConstants.telegramUrl),
                  tooltip: 'Telegram',
                ),

                // Github
                SocialButton(
                  iconPath: 'assets/icons/github.svg',
                  onPressed: () => _launchUrl(AppConstants.githubUrl),
                  tooltip: 'GitHub',
                ),

                // LinkedIn
                SocialButton(
                  iconPath: 'assets/icons/linkedin.svg',
                  onPressed: () => _launchUrl(AppConstants.linkedinUrl),
                  tooltip: 'LinkedIn',
                ),
              ],
            ),
          ),

          SizedBox(height: 48.h),

          // Contact Form
          ScrollAnimatedFadeIn(
            key: const ValueKey('contact_socials'),
            delay: const Duration(milliseconds: 400),
            child: Container(
              constraints: BoxConstraints(maxWidth: 600.w),
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Send me a message',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontVariations: AppConstants.experienceFontEmphasized,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    _buildTextField(
                      theme: theme,
                      controller: _nameController,
                      label: 'Name',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      theme: theme,
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      theme: theme,
                      controller: _subjectController,
                      label: 'Subject',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a subject'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    _buildTextField(
                      theme: theme,
                      controller: _messageController,
                      label: 'Message',
                      maxLines: 5,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a message'
                          : null,
                    ),
                    SizedBox(height: 32.h),

                    M3EButton.icon(
                      onPressed: _isSending ? null : _sendEmail,
                      size: M3EButtonSize.custom(height: 75.r),
                      shape: M3EButtonShape.square,
                      icon: _isSending
                          ? SizedBox(
                              width: 24.r,
                              height: 24.r,
                              child: const Loader(),
                            )
                          : SvgPicture.asset(
                              'assets/icons/send.svg',
                              width: 24.r,
                              height: 24.r,
                              colorFilter: ColorFilter.mode(
                                theme.colorScheme.onPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                      label: Text(_isSending ? 'Sending...' : 'Send Message'),

                      decoration: M3EButtonDecoration.styleFrom(
                        hoveredRadius: 12,
                        pressedRadius: 8,
                        borderRadius: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    required ThemeData theme,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 22.r, horizontal: 16.r),
        labelText: label,
        hoverColor: theme.colorScheme.primary,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.colorScheme.primary),
          borderRadius: BorderRadius.circular(24.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.8, color: theme.colorScheme.primary),
          borderRadius: BorderRadius.circular(24.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
          borderRadius: BorderRadius.circular(24.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.8, color: theme.colorScheme.error),
          borderRadius: BorderRadius.circular(24.r),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        filled: false,
        // Ensure label color also matches the primary theme
        labelStyle: TextStyle(color: theme.colorScheme.primary),
        floatingLabelStyle: TextStyle(color: theme.colorScheme.primary),
      ),

      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
