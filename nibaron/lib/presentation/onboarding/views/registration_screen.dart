import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  bool _isLoading = false;
  bool _isValidPhone = false;
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _phoneController.addListener(_validatePhone);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _validatePhone() {
    final phone = _phoneController.text.replaceAll(' ', '');
    setState(() {
      _isValidPhone = phone.length == 11 && phone.startsWith('01');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_rounded),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              foregroundColor: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '2/4',
                            style: TextStyles.bodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 40),

                            // Phone Icon with gradient
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.phone_android_rounded,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Title and Description Card
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '📱 ${l10n.phoneNumber}',
                                    style: TextStyles.headline2.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.enterPhoneNumber,
                                    style: TextStyles.bodyLarge.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 50),

                            // Enhanced Phone Input
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _isValidPhone ? AppColors.primary : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                                  width: _isValidPhone ? 2 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '🇧🇩',
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '+880',
                                              style: TextStyles.bodyLarge.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.onSurface,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: TextField(
                                          controller: _phoneController,
                                          focusNode: _phoneFocus,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(11),
                                            _PhoneNumberFormatter(),
                                          ],
                                          style: TextStyles.bodyLarge.copyWith(
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '01XXX XXX XXX',
                                            hintStyle: TextStyles.bodyLarge.copyWith(
                                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                      if (_isValidPhone)
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: AppColors.primary,
                                          size: 24,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Validation Message
                            if (_phoneController.text.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _isValidPhone
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _isValidPhone
                                        ? AppColors.primary.withOpacity(0.3)
                                        : Colors.orange.shade200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _isValidPhone
                                          ? Icons.check_circle_outline_rounded
                                          : Icons.info_outline_rounded,
                                      color: _isValidPhone
                                          ? AppColors.primary
                                          : Colors.orange.shade600,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _isValidPhone
                                            ? l10n.validPhoneNumber
                                            : l10n.enterValidPhoneNumber,
                                        style: TextStyles.bodySmall.copyWith(
                                          color: _isValidPhone
                                              ? AppColors.primary
                                              : Colors.orange.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),

                    // Continue Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: _isValidPhone && !_isLoading
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          boxShadow: _isValidPhone && !_isLoading
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.4),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ]
                              : null,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: _isValidPhone && !_isLoading ? _onContinue : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: _isLoading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          l10n.sending,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          l10n.next,
                                          style: TextStyles.bodyLarge.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _isValidPhone ? Colors.white : Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: _isValidPhone ? Colors.white : Colors.grey.shade600,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onContinue() async {
    if (!_isValidPhone || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.pushNamed(
          context,
          '/otp-verification',
          arguments: {'phoneNumber': '+880${_phoneController.text.replaceAll(' ', '')}'},
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');

    if (text.length <= 2) return newValue;

    String formatted = text.substring(0, 2);
    if (text.length > 2) {
      formatted += ' ${text.substring(2, text.length > 5 ? 5 : text.length)}';
    }
    if (text.length > 5) {
      formatted += ' ${text.substring(5)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
