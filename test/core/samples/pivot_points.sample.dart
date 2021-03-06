// ignore_for_file: constant_identifier_names

import 'package:matex_dart/matex_dart.dart';

const PIVOT_POINTS_DEFAULT_RESULTS = MatexPivotPointsResult(
  pivotPoint: 0,
  resistances: [0, 0, 0],
  supports: [0, 0, 0],
);

const PIVOT_POINTS_WOODIE_RESULTS = MatexPivotPointsResult(
  pivotPoint: 1.425,
  resistances: [1.55, 1.625],
  supports: [1.35, 1.225],
);

const PIVOT_POINTS_DEMARK_RESULTS = MatexPivotPointsResult(
  pivotPoint: 1.375,
  resistances: [1.45],
  supports: [1.25],
);

const PIVOT_POINTS_DEMARK_RESULTS_CLOSE_GREATER_OPEN = MatexPivotPointsResult(
  pivotPoint: 1.4375,
  resistances: [1.575],
  supports: [1.375],
);

const PIVOT_POINTS_DEMARK_RESULTS_OPEN_GREATER_CLOSE = MatexPivotPointsResult(
  pivotPoint: 1.355,
  resistances: [1.41],
  supports: [1.21],
);

const PIVOT_POINTS_STANDARD = MatexPivotPointsResult(
  pivotPoint: 1.35,
  resistances: [1.45, 1.6, 1.7],
  supports: [1.2, 1.1, 0.95],
);

const PIVOT_POINTS_FIBONACCI = MatexPivotPointsResult(
  pivotPoint: 1.35,
  resistances: [1.4455, 1.5045, 1.6],
  supports: [1.2545, 1.1955, 1.1],
);

const PIVOT_POINTS_CAMARILLA = MatexPivotPointsResult(
  pivotPoint: 4 / 3,
  resistances: [1.3275, 1.355, 1.3825, 1.465],
  supports: [1.2725, 1.245, 1.2175, 1.135],
);
