import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surfaceCard,
    required this.surfaceElevated,
    required this.imageBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.priceAccent,
    required this.borderSubtle,
    required this.borderStrong,
    required this.glow,
    required this.starRating,
    required this.skeletonBase,
    required this.skeletonHighlight,
  });

  final Color background;

  final Color surfaceCard;

  final Color surfaceElevated;

  final Color imageBg;

  final Color textPrimary;

  final Color textSecondary;

  final Color textMuted;

  final Color accent;

  final Color priceAccent;

  final Color borderSubtle;

  final Color borderStrong;

  final Color glow;

  final Color starRating;

  final Color skeletonBase;

  final Color skeletonHighlight;

  static const dark = AppColors(
    background: Color(0xFF121212),
    surfaceCard: Color(0xFF1B1E23),
    surfaceElevated: Color(0xFF252830),
    imageBg: Color(0xFFFFFFFF),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB0B0B0),
    textMuted: Color(0xFF6B6B6B),
    accent: Color(0xFF03DAC6),
    priceAccent: Color(0xFF03DAC6),
    borderSubtle: Color(0xFF424B5C),
    borderStrong: Color(0xFF5A6478),
    glow: Color(0x4D03DAC6),
    starRating: Color(0xFFFFB300),
    skeletonBase: Color(0xFF2A2D32),
    skeletonHighlight: Color(0xFF3A3D42),
  );

  static const light = AppColors(
    background: Color(0xFFF8FAFC),
    surfaceCard: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    imageBg: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1E293B),
    textSecondary: Color(0xFF64748B),
    textMuted: Color(0xFF94A3B8),
    accent: Color(0xFF6366F1),
    priceAccent: Color(0xFF6366F1),
    borderSubtle: Color(0xFFE2E8F0),
    borderStrong: Color(0xFFCBD5E1),
    glow: Color(0x336366F1),
    starRating: Color(0xFFFFB300),
    skeletonBase: Color(0xFFE2E8F0),
    skeletonHighlight: Color(0xFFF1F5F9),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surfaceCard,
    Color? surfaceElevated,
    Color? imageBg,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? accent,
    Color? priceAccent,
    Color? borderSubtle,
    Color? borderStrong,
    Color? glow,
    Color? starRating,
    Color? skeletonBase,
    Color? skeletonHighlight,
  }) {
    return AppColors(
      background: background ?? this.background,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      imageBg: imageBg ?? this.imageBg,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      accent: accent ?? this.accent,
      priceAccent: priceAccent ?? this.priceAccent,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      glow: glow ?? this.glow,
      starRating: starRating ?? this.starRating,
      skeletonBase: skeletonBase ?? this.skeletonBase,
      skeletonHighlight: skeletonHighlight ?? this.skeletonHighlight,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      imageBg: Color.lerp(imageBg, other.imageBg, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      priceAccent: Color.lerp(priceAccent, other.priceAccent, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      starRating: Color.lerp(starRating, other.starRating, t)!,
      skeletonBase: Color.lerp(skeletonBase, other.skeletonBase, t)!,
      skeletonHighlight: Color.lerp(skeletonHighlight, other.skeletonHighlight, t)!,
    );
  }
}
