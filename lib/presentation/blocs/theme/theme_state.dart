part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDarkMode;

  const ThemeState({
    required this.themeData,
    required this.isDarkMode,
  });

  @override
  List<Object> get props => [themeData, isDarkMode];
}

final class ThemeInitial extends ThemeState {
  ThemeInitial({
    required ThemeData themeData,
    required bool isDarkMode,
  }) : super(themeData: themeData, isDarkMode: isDarkMode);
}
