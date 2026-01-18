import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_extensions.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
    this.hintText = 'Search products...',
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacingMedium,
        AppTheme.spacingSmall,
        AppTheme.spacingMedium,
        AppTheme.spacingMedium,
      ),
      color: colors.background,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: colors.textPrimary, fontSize: 16),
        cursorColor: colors.accent,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: colors.textMuted, fontSize: 16),
          prefixIcon: Icon(Icons.search, color: colors.textMuted, size: 22),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: colors.textMuted, size: 20),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : null,
          filled: true,
          fillColor: colors.surfaceCard,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: BorderSide(color: colors.borderSubtle, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: BorderSide(color: colors.borderSubtle, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: BorderSide(color: colors.accent, width: 1),
          ),
        ),
      ),
    );
  }
}
