import 'package:easy_table/easy_table.dart';
import 'package:easy_table/src/internal/cell_widget.dart';
import 'package:easy_table/src/internal/columns_layout.dart';
import 'package:easy_table/src/internal/columns_layout_child.dart';
import 'package:easy_table/src/internal/row_callbacks.dart';
import 'package:easy_table/src/internal/scroll_offsets.dart';
import 'package:easy_table/src/internal/table_layout_settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
class RowWidget<ROW> extends StatefulWidget {
  RowWidget(
      {required this.index,
      required this.row,
      required this.onHover,
      required this.layoutSettings,
      required this.scrolling,
      required this.columnResizing,
      required this.color,
      required this.model,
      required this.rowCallbacks,
      required this.horizontalScrollOffsets})
      : super(key: ValueKey<int>(index));

  final ROW row;
  final int index;
  final bool scrolling;
  final bool columnResizing;
  final OnRowHoverListener? onHover;
  final EasyTableModel<ROW> model;
  final TableLayoutSettings layoutSettings;
  final RowCallbacks<ROW> rowCallbacks;
  final EasyTableRowColor<ROW>? color;
  final HorizontalScrollOffsets horizontalScrollOffsets;

  @override
  State<StatefulWidget> createState() => RowWidgetState<ROW>();
}

class RowWidgetState<ROW> extends State<RowWidget<ROW>> {
  late RowData<ROW> _rowData;

  @override
  void initState() {
    super.initState();
    _rowData = RowData(row: widget.row, index: widget.index, hovered: false);
  }

  @override
  void didUpdateWidget(covariant RowWidget<ROW> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _rowData = RowData(
        row: widget.row, index: widget.index, hovered: _rowData.hovered);
  }

  @override
  Widget build(BuildContext context) {
    EasyTableThemeData theme = EasyTableTheme.of(context);

    List<ColumnsLayoutChild<ROW>> children = [];

    for (int columnIndex = 0;
        columnIndex < widget.model.columnsLength;
        columnIndex++) {
      final EasyTableColumn<ROW> column = widget.model.columnAt(columnIndex);
      final CellWidget<ROW> cell = CellWidget(
          column: column, columnIndex: columnIndex, rowData: _rowData);

      children.add(ColumnsLayoutChild<ROW>(index: columnIndex, child: cell));
    }

    Widget layout = ColumnsLayout(
        layoutSettings: widget.layoutSettings,
        horizontalScrollOffsets: widget.horizontalScrollOffsets,
        paintDividerColumns: false,
        children: children);

    if (widget.rowCallbacks.hasCallback) {
      layout = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _buildOnTap(),
          onDoubleTap: _buildOnDoubleTap(),
          onSecondaryTap: _buildOnSecondaryTap(),
          child: layout);
    }

    Color? color;
    if (widget.color != null) {
      color = widget.color!(_rowData);
    }

    if (!widget.scrolling &&
        !widget.columnResizing &&
        (widget.rowCallbacks.hasCallback ||
            theme.row.hoverBackground != null ||
            theme.row.hoverForeground != null ||
            widget.onHover != null)) {
      if (_rowData.hovered && theme.row.hoverBackground != null) {
        // replace row color
        color = theme.row.hoverBackground!(widget.index);
      }
      _ColorPainter? hoverBackground;
      if (color != null) {
        // row color or hover background
        hoverBackground = _ColorPainter(color);
      }
      _ColorPainter? hoverForeground;
      if (_rowData.hovered && theme.row.hoverForeground != null) {
        Color? color = theme.row.hoverForeground!(widget.index);
        if (color != null) {
          hoverForeground = _ColorPainter(color);
        }
      }
      layout = CustomPaint(
          painter: hoverBackground,
          foregroundPainter: hoverForeground,
          child: layout);
      layout = MouseRegion(
          onEnter: _onEnter,
          cursor: widget.rowCallbacks.hasCallback
              ? SystemMouseCursors.click
              : MouseCursor.defer,
          onExit: _onExit,
          child: layout);
    } else if (color != null) {
      layout = Container(color: color, child: layout);
    }

    return layout;
  }

  GestureTapCallback? _buildOnTap() {
    if (widget.rowCallbacks.onRowTap != null) {
      return () => widget.rowCallbacks.onRowTap!(widget.row);
    }
    return null;
  }

  GestureTapCallback? _buildOnDoubleTap() {
    if (widget.rowCallbacks.onRowDoubleTap != null) {
      return () => widget.rowCallbacks.onRowDoubleTap!(widget.row);
    }
    return null;
  }

  GestureTapCallback? _buildOnSecondaryTap() {
    if (widget.rowCallbacks.onRowSecondaryTap != null) {
      return () => widget.rowCallbacks.onRowSecondaryTap!(widget.row);
    }
    return null;
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _rowData = RowData(row: widget.row, index: widget.index, hovered: true);
      if (widget.onHover != null) {
        widget.onHover!(widget.index);
      }
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _rowData = RowData(row: widget.row, index: widget.index, hovered: false);
      if (widget.onHover != null) {
        widget.onHover!(null);
      }
    });
  }
}

class _ColorPainter extends CustomPainter {
  _ColorPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _ColorPainter oldDelegate) =>
      color != oldDelegate.color;
}
