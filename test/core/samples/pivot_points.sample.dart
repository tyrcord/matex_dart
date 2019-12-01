import 'package:matex_dart/matex_dart.dart';

final PIVOT_POINTS_WOODIE_RESULTS = PivotPointsResult(
  pivotPoint: 1.425,
  resistances: [1.55, 1.625],
  supports: [1.35, 1.225],
);

final PIVOT_POINTS_DEMARK_RESULTS = PivotPointsResult(
  pivotPoint: 1.375,
  resistances: [1.45],
  supports: [1.25],
);

final PIVOT_POINTS_DEMARK_RESULTS_CLOSE_GREATER_OPEN = PivotPointsResult(
  pivotPoint: 1.4375,
  resistances: [1.575],
  supports: [1.375],
);

final PIVOT_POINTS_DEMARK_RESULTS_OPEN_GREATER_CLOSE = PivotPointsResult(
  pivotPoint: 1.355,
  resistances: [1.41],
  supports: [1.21],
);

final PIVOT_POINTS_STANDARD = PivotPointsResult(
  pivotPoint: 1.35,
  resistances: [1.45, 1.6, 1.7],
  supports: [1.2, 1.1, 0.95],
);

final PIVOT_POINTS_FIBONACCI = PivotPointsResult(
  pivotPoint: 1.35,
  resistances: [1.4455, 1.5045, 1.6],
  supports: [1.2545, 1.1955, 1.1],
);

final PIVOT_POINTS_CAMARILLA = PivotPointsResult(
  pivotPoint: 4 / 3,
  resistances: [1.3275, 1.355, 1.3825, 1.465],
  supports: [1.2725, 1.245, 1.2175, 1.135],
);
