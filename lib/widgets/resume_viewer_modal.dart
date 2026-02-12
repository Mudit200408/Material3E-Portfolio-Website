import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:responsive_scaler/responsive_scaler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
import 'package:portfolio_web/core/utils/file_downloader.dart';

class ResumeViewerModal extends StatefulWidget {
  final String resumeUrl;
  const ResumeViewerModal({super.key, required this.resumeUrl});

  @override
  State<ResumeViewerModal> createState() => _ResumeViewerModalState();
}

class _ResumeViewerModalState extends State<ResumeViewerModal> {
  late PdfControllerPinch _pdfController;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: _fetchPdfDocument(widget.resumeUrl),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  Future<PdfDocument> _fetchPdfDocument(String url) async {
    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = Uint8List.fromList(response.data);
    return PdfDocument.openData(bytes);
  }

  Future<void> _downloadAndOpen() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _error = null;
    });

    try {
      final dio = Dio();
      final response = await dio.get(
        widget.resumeUrl,
        onReceiveProgress: (received, total) {
          if (total != -1 && mounted) {
            setState(() => _downloadProgress = received / total);
          }
        },
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = Uint8List.fromList(response.data);

      setState(() {
        _isDownloading = false;
        _downloadProgress = 0.0;
      });

      await downloadAndOpen('resume.pdf', bytes);
    } catch (e) {
      setState(() {
        _isDownloading = false;
        _downloadProgress = 0.0;
        _error = e.toString();
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Resume',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontVariations: const [
                          FontVariation('wght', 800),
                          FontVariation('ROND', 100),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _error != null
                  ? const Center(child: Text('Error loading PDF'))
                  : PdfViewPinch(controller: _pdfController),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 6.r),
              child: Column(
                children: [
                  if (_isDownloading)
                    Column(
                      children: [
                        LinearProgressIndicator(value: _downloadProgress),
                        SizedBox(height: 8.h),
                        Text(
                          '${(_downloadProgress * 100).toStringAsFixed(0)}% downloading...',
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48.h,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Open'),
                              onPressed: () async {
                                final uri = Uri.parse(widget.resumeUrl);
                                if (!await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Could not open externally.',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: SizedBox(
                            height: 48.h,
                            child: ElevatedButton.icon(
                              onPressed: _downloadAndOpen,
                              icon: const Icon(Icons.download),
                              label: const Text('Download'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
