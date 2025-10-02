import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import '../../../core/services/onboarding_service.dart';
import '../../../data/providers/locale_provider.dart';

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends ConsumerState<LanguageSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String? _selectedLanguage;
  bool _isLoading = false;
  late List<Language> _languages;

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

    _languages = OnboardingService.getSupportedLanguages();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set initial selected language from current locale
      final currentLocale = ref.read(localeProvider);
      setState(() {
        _selectedLanguage = currentLocale.languageCode;
      });

      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
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
                    // Header with step indicator
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
                            '1/4',
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

                            // Language Icon with gradient
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
                                Icons.language_rounded,
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
                                    l10n.selectLanguage,
                                    style: TextStyles.headline2.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.chooseLanguageMessage,
                                    style: TextStyles.bodyLarge.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Language Options
                            ...List.generate(_languages.length, (index) {
                              return _buildLanguageCard(_languages[index], index);
                            }),

                            const SizedBox(height: 40),
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
                          color: _selectedLanguage != null && !_isLoading
                              ? AppColors.primary
                              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                          boxShadow: _selectedLanguage != null && !_isLoading
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.4),
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
                            onTap: _selectedLanguage != null && !_isLoading ? _onContinue : null,
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
                                          l10n.settingUp,
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
                                          l10n.continueButton,
                                          style: TextStyles.bodyLarge.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _selectedLanguage != null ? Colors.white : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: _selectedLanguage != null ? Colors.white : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
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

  Widget _buildLanguageCard(Language language, int index) {
    final isSelected = _selectedLanguage == language.code;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            setState(() {
              _selectedLanguage = language.code;
            });

            // Immediately change the language using the locale provider
            final locale = language.code == 'bn' ? const Locale('bn', 'BD') : const Locale('en', 'US');
            await ref.read(localeProvider.notifier).setLocale(locale);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : Theme.of(context).shadowColor.withValues(alpha: 0.05),
                  blurRadius: isSelected ? 15 : 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Flag Container
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      language.flag,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // Language Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language.name,
                        style: TextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        language.nativeName,
                        style: TextStyles.bodyMedium.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                // Selection Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onContinue() async {
    if (_selectedLanguage == null || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      // The language has already been set through the locale provider when selected
      // Just add a small delay for UX and navigate
      await Future.delayed(const Duration(milliseconds: 800));

      if (mounted) {
        Navigator.pushNamed(context, '/onboarding-slides');
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
