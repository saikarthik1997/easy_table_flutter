import 'dart:math' as math;
import 'package:easy_table/src/cell_builder.dart';
import 'package:easy_table/src/value_mapper.dart';
import 'package:flutter/widgets.dart';

/// Signature for sort column function.
typedef EasyTableColumnSort<ROW> = int Function(ROW a, ROW b);

/// The [EasyTable] column.
///
/// The [name] argument is optional and is used by the default
/// cell header widget.
///
/// The optional value mappings [intValue], [doubleValue], [stringValue] and
/// [objectValue] allows automatic cell configuration by identifying
/// and displaying data types in the row object.
///
/// The [cellBuilder] builds a cell widget for each row in that column.
/// A default [cellBuilder] will be used if the column has any value
/// mapping defined.
///
/// This column is sortable if the argument [sortable] is [TRUE] and
/// a [sort] has been defined for ascending sort. Descending sort
/// is applied by inverting the arguments in [sort].
///
/// The default value of [sortable] is [TRUE].
///
/// If the [sort] is not set, it will be created automatically
/// for the value mappings.
///
/// The [fractionDigits] is the optional decimal-point string-representation
/// used by the default cell width when the [doubleValue] is set.
class EasyTableColumn<ROW> extends ChangeNotifier {
  factory EasyTableColumn(
      {dynamic id,
      double width = 100,
      double weight = 1,
      String? name,
      int? fractionDigits,
      bool sortable = true,
      bool resizable = true,
      EdgeInsets? padding,
      AlignmentGeometry? alignment,
      TextStyle? textStyle,
      EasyTableCellBuilder<ROW>? cellBuilder,
      EasyTableColumnSort<ROW>? sort,
      EasyTableIntValueMapper<ROW>? intValue,
      EasyTableDoubleValueMapper<ROW>? doubleValue,
      EasyTableStringValueMapper<ROW>? stringValue,
      EasyTableObjectValueMapper<ROW>? objectValue}) {
    if (sort == null) {
      if (intValue != null) {
        sort = (a, b) {
          int? v1 = intValue(a);
          int? v2 = intValue(b);
          if (v1 == null && v2 == null) {
            return 0;
          }
          if (v1 == null) {
            return -1;
          }
          if (v2 == null) {
            return 1;
          }
          return v1.compareTo(v2);
        };
      } else if (doubleValue != null) {
        sort = (a, b) {
          double? v1 = doubleValue(a);
          double? v2 = doubleValue(b);
          if (v1 == null && v2 == null) {
            return 0;
          }
          if (v1 == null) {
            return -1;
          }
          if (v2 == null) {
            return 1;
          }
          return v1.compareTo(v2);
        };
      } else if (stringValue != null) {
        sort = (a, b) {
          String? v1 = stringValue(a);
          String? v2 = stringValue(b);
          if (v1 == null && v2 == null) {
            return 0;
          }
          if (v1 == null) {
            return -1;
          }
          if (v2 == null) {
            return 1;
          }
          return v1.compareTo(v2);
        };
      } else if (objectValue != null) {
        sort = (a, b) {
          Object? v1 = objectValue(a);
          Object? v2 = objectValue(b);
          if (v1 == null && v2 == null) {
            return 0;
          }
          if (v1 == null) {
            return -1;
          }
          if (v2 == null) {
            return 1;
          }
          if (a is Comparable && b is Comparable) {
            return a.compareTo(b);
          }
          return 0;
        };
      }
    }
    //TODO check multiple value mappers
    return EasyTableColumn._(
        id: id,
        width: width,
        weight: weight,
        name: name,
        fractionDigits: fractionDigits,
        cellBuilder: cellBuilder,
        sort: sort,
        stringValueMapper: stringValue,
        intValueMapper: intValue,
        doubleValueMapper: doubleValue,
        objectValueMapper: objectValue,
        sortable: sortable,
        resizable: resizable,
        padding: padding,
        alignment: alignment,
        textStyle: textStyle);
  }

  EasyTableColumn._(
      {this.id,
      required double width,
      required double weight,
      this.name,
      this.padding,
      this.alignment,
      this.textStyle,
      this.fractionDigits,
      this.cellBuilder,
      this.sort,
      this.stringValueMapper,
      this.intValueMapper,
      this.doubleValueMapper,
      this.objectValueMapper,
      required this.resizable,
      required bool sortable})
      : _width = width,
        _weight = weight,
        _sortable = sortable;

  final dynamic id;
  final String? name;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignment;
  final TextStyle? textStyle;
  final int? fractionDigits;
  final EasyTableCellBuilder<ROW>? cellBuilder;
  final EasyTableColumnSort<ROW>? sort;
  final EasyTableIntValueMapper<ROW>? intValueMapper;
  final EasyTableDoubleValueMapper<ROW>? doubleValueMapper;
  final EasyTableStringValueMapper<ROW>? stringValueMapper;
  final EasyTableObjectValueMapper<ROW>? objectValueMapper;
  final bool _sortable;
  double _width;
  double _weight;

  double get weight => _weight;
  set weight(double value) {
    //TODO resizeAreaWidth should be smaller
    value = math.max(1, value);
    if (_weight != value) {
      _weight = value;
      notifyListeners();
    }
  }

  double get width => _width;
  set width(double value) {
    //TODO resizeAreaWidth should be smaller
    value = math.max(16, value);
    if (_width != value) {
      _width = value;
      notifyListeners();
    }
  }

  bool get sortable => _sortable && sort != null;

  bool resizable;

  @override
  String toString() {
    return 'EasyTableColumn{name: $name}';
  }
}
