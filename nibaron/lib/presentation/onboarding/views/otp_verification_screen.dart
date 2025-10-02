import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen>
    with TickerProviderStateMixin {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (index) => FocusNode());
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _bounceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _bounceAnimation;

  bool _isLoading = false;
  bool _canResend = false;
  int _resendCountdown = 60;
  String _enteredOtp = '';

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));

    // Setup OTP input listeners
    for (int i = 0; i < _otpControllers.length; i++) {
      _otpControllers[i].addListener(() => _updateOtp());
    }

    _startResendTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeController.forward();
      _slideController.forward();
      _bounceController.forward();
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _fadeController.dispose();
    _slideController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _updateOtp() {
    final otp = _otpControllers.map((controller) => controller.text).join();
    setState(() {
      _enteredOtp = otp;
    });

    if (otp.length == 6) {
      _verifyOtp();
    }
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _resendCountdown--;
        });
        if (_resendCountdown <= 0) {
          setState(() {
            _canResend = true;
          });
          return false;
        }
        return true;
      }
      return false;
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
                            '3/4',
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

                            // OTP Icon with bounce animation
                            ScaleTransition(
                              scale: _bounceAnimation,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.security_rounded,
                                  size: 50,
                                  color: Colors.white,
                                ),
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
                                    l10n.verifyOtp,
                                    style: TextStyles.headline2.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.enterOtpMessage,
                                    style: TextStyles.bodyLarge.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.phoneNumber,
                                    style: TextStyles.bodyLarge.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 50),

                            // OTP Input Fields
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    l10n.enterOtpCode,
                                    style: TextStyles.bodyMedium.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: List.generate(6, (index) {
                                      return _buildOtpField(index);
                                    }),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Resend OTP Section
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _canResend
                                        ? l10n.didntReceiveCode
                                        : l10n.resendInSeconds(_resendCountdown),
                                    style: TextStyles.bodyMedium.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                  if (_canResend) ...[
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: _resendOtp,
                                      child: Text(
                                        ' ${l10n.resend}',
                                        style: TextStyles.bodyMedium.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),

                    // Verify Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: _enteredOtp.length == 6 && !_isLoading
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          boxShadow: _enteredOtp.length == 6 && !_isLoading
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
                            onTap: _enteredOtp.length == 6 && !_isLoading ? _verifyOtp : null,
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
                                          l10n.verifying,
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
                                          l10n.verify,
                                          style: TextStyles.bodyLarge.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _enteredOtp.length == 6 ? Colors.white : Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.verified_rounded,
                                          color: _enteredOtp.length == 6 ? Colors.white : Colors.grey.shade600,
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

  Widget _buildOtpField(int index) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _otpControllers[index].text.isNotEmpty
              ? AppColors.primary
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          width: _otpControllers[index].text.isNotEmpty ? 2 : 1,
        ),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _otpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyles.headline3.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _otpFocusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  void _verifyOtp() async {
    if (_enteredOtp.length != 6 || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Simulate OTP verification
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.pushNamed(context, '/farm-setup');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _resendOtp() async {
    if (!_canResend) return;

    try {
      // Simulate resending OTP
      await Future.delayed(const Duration(milliseconds: 500));

      _startResendTimer();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
