import 'package:easy_table/src/column.dart';
import 'package:easy_table/src/internal/columns_layout.dart';
import 'package:easy_table/src/internal/columns_layout_child.dart';
import 'package:easy_table/src/internal/header_cell.dart';
import 'package:easy_table/src/internal/scroll_offsets.dart';
import 'package:easy_table/src/internal/table_layout_settings.dart';
import 'package:easy_table/src/model.dart';
import 'package:easy_table/src/theme/theme.dart';
import 'package:easy_table/src/theme/theme_data.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class HeaderWidget<ROW> extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.layoutSettings,
    required this.model,
    required this.resizable,
    required this.multiSort,
    required this.horizontalScrollOffsets,
  }) : super(key: key);

  final TableLayoutSettings layoutSettings;
  final EasyTableModel<ROW> model;
  final bool resizable;
  final bool multiSort;
  final HorizontalScrollOffsets horizontalScrollOffsets;

  @override
  Widget build(BuildContext context) {
    EasyTableThemeData theme = EasyTableTheme.of(context);

    List<ColumnsLayoutChild<ROW>> children = [];

    for (int columnIndex = 0;
        columnIndex < model.columnsLength;
        columnIndex++) {
      final EasyTableColumn<ROW> column = model.columnAt(columnIndex);

      final Widget cell = EasyTableHeaderCell<ROW>(
          columnMinWidth: model.minColumnWidth,
          key: ValueKey<int>(columnIndex),
          model: model,
          column: column,
          resizable: resizable,
          multiSort: multiSort);
      children.add(ColumnsLayoutChild<ROW>(index: columnIndex, child: cell));
    }

    Widget header = ColumnsLayout(
        layoutSettings: layoutSettings,
        horizontalScrollOffsets: horizontalScrollOffsets,
        paintDividerColumns: true,
        children: children);

    Color? color = theme.header.color;
    BoxBorder? border;
    if (theme.header.bottomBorderHeight > 0 &&
        theme.header.bottomBorderColor != null) {
      border = Border(
          bottom: BorderSide(
              width: theme.header.bottomBorderHeight,
              color: theme.header.bottomBorderColor!));
    }

    if (color != null || border != null) {
      header = Container(
          decoration: BoxDecoration(border: border, color: color),
          child: header);
    }
    return header;
  }
}
