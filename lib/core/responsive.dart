import 'package:flutter/material.dart';

/// Helpers de diseño responsive para PC Fútbol 2026.
///
/// Mantiene la estética oscura del simulador (paleta `0xFF020617` /
/// `0xFFDEFF9A`) en cualquier tamaño de pantalla: móvil vertical,
/// tablet, escritorio y Web.
class Responsive {
  Responsive._();

  /// Anchos tomados de Material 3:
  ///  - compact  (<600)   → móvil vertical
  ///  - medium   (600–839)→ móvil landscape / tablet pequeña
  ///  - expanded (≥840)   → tablet grande / escritorio / web
  static const double compactMax = 600;
  static const double mediumMax = 840;

  /// Devuelve el breakpoint actual en función del ancho disponible.
  static ScreenSize breakpoint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < compactMax) return ScreenSize.compact;
    if (width < mediumMax) return ScreenSize.medium;
    return ScreenSize.expanded;
  }

  /// Devuelve el breakpoint a partir de un ancho directo (útil en
  /// `LayoutBuilder` o widgets sin `MediaQuery`).
  static ScreenSize breakpointFromWidth(double width) {
    if (width < compactMax) return ScreenSize.compact;
    if (width < mediumMax) return ScreenSize.medium;
    return ScreenSize.expanded;
  }

  /// Selecciona uno de tres valores según el breakpoint.
  static T value<T>(BuildContext context, T compact, T medium, T expanded) {
    switch (breakpoint(context)) {
      case ScreenSize.compact:
        return compact;
      case ScreenSize.medium:
        return medium;
      case ScreenSize.expanded:
        return expanded;
    }
  }

  /// Igual que [value] pero con un ancho explícito.
  static T valueFromWidth<T>(
      double width, T compact, T medium, T expanded) {
    switch (breakpointFromWidth(width)) {
      case ScreenSize.compact:
        return compact;
      case ScreenSize.medium:
        return medium;
      case ScreenSize.expanded:
        return expanded;
    }
  }

  /// Padding horizontal que crece con el breakpoint.
  static double horizontalPadding(BuildContext context) =>
      value<double>(context, 16, 24, 40);

  /// Padding vertical estándar.
  static double verticalPadding(BuildContext context) =>
      value<double>(context, 12, 16, 20);

  /// Devuelve un número de columnas apropiado para grids tipo "menú".
  /// Se puede acotar con [min] y [max] según el caso.
  static int gridColumns(BuildContext context, {int min = 2, int max = 5}) {
    final raw = value<int>(context, 2, 3, 4);
    if (MediaQuery.of(context).size.width >= 1200) {
      return (raw + 1).clamp(min, max);
    }
    return raw.clamp(min, max);
  }

  /// `aspectRatio` de cada celda del grid. Más cuadrado en móvil,
  /// más apaisado en escritorio para llenar el espacio sobrante.
  static double gridAspectRatio(BuildContext context) =>
      value<double>(context, 0.95, 1.05, 1.2);

  /// Ancho máximo recomendado para contenido "tipo app" en pantallas
  /// muy anchas (escritorio/Web). Por encima de este ancho centramos
  /// y dejamos margen a los lados.
  static double maxContentWidth(BuildContext context) =>
      value<double>(context, double.infinity, 720, 960);

  /// Factor de escala tipográfico. Respeta la accesibilidad del
  /// usuario (`MediaQuery.textScaler`) sin pasarse de un 130%.
  static double textScale(BuildContext context) {
    final scaler = MediaQuery.of(context).textScaler.scale(1.0);
    return scaler.clamp(0.85, 1.30);
  }

  /// Envuelve un widget en un layout responsive con `SafeArea` y,
  /// opcionalmente, un `ConstrainedBox` para que no se estire a lo
  /// ancho en escritorio.
  ///
  /// Uso:
  /// ```dart
  /// body: Responsive.page(
  ///   context: context,
  ///   child: myBody(),
  /// )
  /// ```
  static Widget page({
    required BuildContext context,
    required Widget child,
    bool constrainWidth = true,
    EdgeInsetsGeometry? padding,
  }) {
    final pad = padding ??
        EdgeInsets.symmetric(
          horizontal: horizontalPadding(context),
          vertical: verticalPadding(context),
        );
    Widget body = SafeArea(child: Padding(padding: pad, child: child));
    if (constrainWidth) {
      body = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth(context)),
          child: body,
        ),
      );
    }
    return body;
  }
}

enum ScreenSize { compact, medium, expanded }