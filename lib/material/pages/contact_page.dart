import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_web/core/loader/loader.dart';
import 'package:portfolio_web/material/widgets/scroll_animated_fade_in.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final String _myEmail = '[EMAIL_ADDRESS]'; //TODO: Add your email address
  final String _githubUrl = '[GITHUB_URL]'; //TODO: Add your github url
  final String _linkedinUrl = '[LINKEDIN_URL]'; //TODO: Add your linkedin url
  final String _accessKey =
      '[ACCESS_KEY]'; //TODO: Add your access key  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      try {
        final response = await http.post(
          Uri.parse('https://api.web3forms.com/submit'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'access_key': _accessKey,
            'name': _nameController.text,
            'email': _emailController.text,
            'subject': _subjectController.text,
            'message': _messageController.text,
          }),
        );

        if (mounted) {
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Message sent successfully!')),
            );
            _nameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to send message: ${response.body}'),
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
        left: 24.scale(),
        right: 24.scale(),
        top: 65.scale(),
        bottom: 32.scale(),
      ),
      child: Column(
        children: [
          ScrollAnimatedFadeIn(
            child: Text(
              'Get in Touch',
              style: theme.textTheme.displaySmall?.copyWith(
                fontVariations: const [
                  FontVariation('wght', 800),
                  FontVariation('GRAD', 50),
                  FontVariation('wdth', 50),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.scale()),
          ScrollAnimatedFadeIn(
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Feel free to reach out for collaborations or just a friendly hello',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32.scale()),

          // Social Buttons
          ScrollAnimatedFadeIn(
            delay: const Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16.scale(),
              children: [
                _SocialButton(
                  iconPath: 'assets/icons/email.svg',
                  onPressed: () => _launchUrl('mailto:$_myEmail'),
                  tooltip: 'Email',
                ),

                _SocialButton(
                  iconPath: 'assets/icons/github.svg',
                  onPressed: () => _launchUrl(_githubUrl),
                  tooltip: 'GitHub',
                ),
                _SocialButton(
                  iconPath: 'assets/icons/linkedin.svg',
                  onPressed: () => _launchUrl(_linkedinUrl),
                  tooltip: 'LinkedIn',
                ),
              ],
            ),
          ),

          SizedBox(height: 48.scale()),

          // Contact Form
          ScrollAnimatedFadeIn(
            delay: const Duration(milliseconds: 400),
            child: Container(
              constraints: BoxConstraints(maxWidth: 600.scale()),
              padding: EdgeInsets.all(24.scale()),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryFixed.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(32.scale()),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Send me a message',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontVariations: const [
                          FontVariation('wght', 700),
                          FontVariation('wdth', 50),
                          FontVariation('ROND', 50),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.scale()),
                    _buildTextField(
                      theme: theme,
                      controller: _nameController,
                      label: 'Name',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
                    ),
                    SizedBox(height: 16.scale()),
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
                    SizedBox(height: 16.scale()),
                    _buildTextField(
                      theme: theme,
                      controller: _subjectController,
                      label: 'Subject',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a subject'
                          : null,
                    ),
                    SizedBox(height: 16.scale()),
                    _buildTextField(
                      theme: theme,
                      controller: _messageController,
                      label: 'Message',
                      maxLines: 5,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a message'
                          : null,
                    ),
                    SizedBox(height: 32.scale()),
                    FilledButton.icon(
                      onPressed: _isSending ? null : _sendEmail,
                      label: Text(_isSending ? 'Sending...' : 'Send Message'),
                      icon: _isSending
                          ? SizedBox(
                              width: 24.scale(),
                              height: 24.scale(),
                              child: const Loader(),
                            )
                          : SvgPicture.asset(
                              'assets/icons/send.svg',
                              width: 24.scale(),
                              height: 24.scale(),
                              colorFilter: ColorFilter.mode(
                                theme.colorScheme.onPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.scale()),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 32.scale()),
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
        contentPadding: EdgeInsets.symmetric(
          vertical: 22.scale(),
          horizontal: 16.scale(),
        ),
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          borderRadius: BorderRadius.circular(24.scale()),
        ),
        filled: false,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String? iconPath;
  final IconData? icon;
  final VoidCallback onPressed;
  final String tooltip;

  const _SocialButton({
    this.iconPath,
    this.icon,
    required this.onPressed,
    required this.tooltip,
  }) : assert(iconPath != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      icon: iconPath != null
          ? SvgPicture.asset(
              iconPath!,
              width: 24.scale(),
              height: 24.scale(),
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSecondaryContainer,
                BlendMode.srcIn,
              ),
            )
          : Icon(icon, size: 24.scale()),
      tooltip: tooltip,
      style: IconButton.styleFrom(padding: EdgeInsets.all(16.scale())),
    );
  }
}
