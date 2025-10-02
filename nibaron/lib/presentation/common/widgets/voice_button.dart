import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/text_to_speech_service.dart';
import '../../../core/dependency_injection/service_locator.dart';

enum VoiceButtonSize { small, medium, large }

class VoiceButton extends ConsumerStatefulWidget {
  final String text;
  final VoiceButtonSize size;
  final String? language;
  final Color? color;
  final VoidCallback? onPressed;

  const VoiceButton({
    super.key,
    required this.text,
    this.size = VoiceButtonSize.medium,
    this.language,
    this.color,
    this.onPressed,
  });

  @override
  ConsumerState<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends ConsumerState<VoiceButton>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  final TextToSpeechService _ttsService = sl<TextToSpeechService>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getButtonSize();
    final iconSize = _getIconSize();

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isPlaying ? _pulseAnimation.value : 1.0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _handleTap,
              borderRadius: BorderRadius.circular(buttonSize / 2),
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  color: widget.color ?? Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  _isPlaying ? Icons.volume_up : Icons.volume_up_outlined,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getButtonSize() {
    switch (widget.size) {
      case VoiceButtonSize.small:
        return 36.0;
      case VoiceButtonSize.medium:
        return 48.0;
      case VoiceButtonSize.large:
        return 60.0;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case VoiceButtonSize.small:
        return 18.0;
      case VoiceButtonSize.medium:
        return 24.0;
      case VoiceButtonSize.large:
        return 30.0;
    }
  }

  Future<void> _handleTap() async {
    widget.onPressed?.call();

    if (_isPlaying) {
      await _stopSpeaking();
    } else {
      await _startSpeaking();
    }
  }

  Future<void> _startSpeaking() async {
    setState(() {
      _isPlaying = true;
    });

    _animationController.repeat(reverse: true);

    try {
      await _ttsService.speak(
        widget.text,
        language: widget.language,
      );
    } catch (e) {
      print('Error speaking text: $e');
    } finally {
      await _stopSpeaking();
    }
  }

  Future<void> _stopSpeaking() async {
    setState(() {
      _isPlaying = false;
    });

    _animationController.stop();
    _animationController.reset();

    try {
      await _ttsService.stop();
    } catch (e) {
      print('Error stopping speech: $e');
    }
  }
}
