import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/routes/app_routes.dart';

class FarmSetupScreen extends ConsumerStatefulWidget {
  const FarmSetupScreen({super.key});

  @override
  ConsumerState<FarmSetupScreen> createState() => _FarmSetupScreenState();
}

class _FarmSetupScreenState extends ConsumerState<FarmSetupScreen>
    with TickerProviderStateMixin {
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _farmSizeController = TextEditingController();
  final FocusNode _farmNameFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  final FocusNode _farmSizeFocus = FocusNode();

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool _isLoading = false;
  String _selectedFarmType = '';
  List<String> _selectedCrops = [];
  String _selectedUnit = 'Acres';

  final List<String> _farmTypes = ['Small Scale', 'Medium Scale', 'Large Scale', 'Commercial'];
  final List<String> _cropTypes = ['Rice', 'Wheat', 'Corn', 'Vegetables', 'Fruits', 'Cotton', 'Sugarcane', 'Others'];
  final List<String> _sizeUnits = ['Acres', 'Hectares', 'Square Meters'];

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

    _scaleController = AnimationController(
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

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaleController.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        _fadeController.forward();
        _slideController.forward();
      });
    });
  }

  @override
  void dispose() {
    _farmNameController.dispose();
    _locationController.dispose();
    _farmSizeController.dispose();
    _farmNameFocus.dispose();
    _locationFocus.dispose();
    _farmSizeFocus.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _farmNameController.text.isNotEmpty &&
           _locationController.text.isNotEmpty &&
           _farmSizeController.text.isNotEmpty &&
           _selectedFarmType.isNotEmpty &&
           _selectedCrops.isNotEmpty;
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
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
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
                        '4/4',
                        style: TextStyles.bodyMedium.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          // Farm Icon with scale animation
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
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
                                Icons.agriculture_rounded,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Title Card
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
                                  '🚜 ${l10n.farmSetup}',
                                  style: TextStyles.headline2.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Set up your farm details to get personalized recommendations',
                                  style: TextStyles.bodyLarge.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Farm Details Form
                          _buildFormSection(
                            title: l10n.farmInformation,
                            icon: Icons.info_outline_rounded,
                            children: [
                              _buildTextField(
                                controller: _farmNameController,
                                focusNode: _farmNameFocus,
                                label: l10n.farmName,
                                hint: l10n.enterFarmName,
                                icon: Icons.landscape_rounded,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _locationController,
                                focusNode: _locationFocus,
                                label: l10n.location,
                                hint: l10n.cityDistrict,
                                icon: Icons.location_on_rounded,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _buildTextField(
                                      controller: _farmSizeController,
                                      focusNode: _farmSizeFocus,
                                      label: l10n.farmSize,
                                      hint: '0.0',
                                      icon: Icons.straighten_rounded,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildDropdown(
                                      value: _selectedUnit,
                                      items: _sizeUnits,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedUnit = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Farm Type Selection
                          _buildFormSection(
                            title: l10n.farmType,
                            icon: Icons.category_rounded,
                            children: [
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: _farmTypes.map((type) {
                                  return _buildSelectionChip(
                                    label: type,
                                    isSelected: _selectedFarmType == type,
                                    onTap: () {
                                      setState(() {
                                        _selectedFarmType = type;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Crop Types Selection
                          _buildFormSection(
                            title: l10n.cropTypes,
                            icon: Icons.eco_rounded,
                            subtitle: l10n.selectAllCrops,
                            children: [
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: _cropTypes.map((crop) {
                                  return _buildSelectionChip(
                                    label: crop,
                                    isSelected: _selectedCrops.contains(crop),
                                    onTap: () {
                                      setState(() {
                                        if (_selectedCrops.contains(crop)) {
                                          _selectedCrops.remove(crop);
                                        } else {
                                          _selectedCrops.add(crop);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),

                // Complete Setup Button
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _isFormValid && !_isLoading
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      boxShadow: _isFormValid && !_isLoading
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
                        onTap: _isFormValid && !_isLoading ? _completeSetup : null,
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
                                      l10n.completeSetup,
                                      style: TextStyles.bodyLarge.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: _isFormValid ? Colors.white : Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: _isFormValid ? Colors.white : Colors.grey.shade600,
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
    );
  }

  Widget _buildFormSection({
    required String title,
    required IconData icon,
    String? subtitle,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.05),
            blurRadius: 15,
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
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyles.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: controller.text.isNotEmpty ? AppColors.primary : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            style: TextStyles.bodyLarge.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyles.bodyLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              prefixIcon: Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: Container(),
        style: TextStyles.bodyLarge.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        dropdownColor: Theme.of(context).colorScheme.surface,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSelectionChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyles.bodyMedium.copyWith(
            color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _completeSetup() async {
    if (!_isFormValid || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      // Simulate setup completion
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Navigate to main app or dashboard
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Setup failed: $e'),
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
