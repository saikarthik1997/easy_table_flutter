## 2.2.0

* Bugfix
  * Functions `onLastRowWidget` and `onLastVisibleRow` are not working properly.
  * Data is not displayed after creating a new model and scrollbar offset not reset.
* API change
  * The `lastVisibleRowIndex` parameter of the `OnLastVisibleRowListener` function is now nullable.

## 2.1.0

* Improvements
  * Improved performance by avoiding unnecessary rebuilds. 
* Bugfix
  * Scrolling does not work with a trackpad on macOS.
* New `EasyTableColumn` property
  * `cellClip`

## 2.0.1

* Bugfix
  * Child text field does not change with typing events.
  * Focus traversal skipping child.

## 2.0.0

* Improvements
  * Property to display vertical scrollbar only when needed
  * Header visibility
  * `lastRowWidget` to allow proper infinite scrolling within the table body
  * More theme configurations
* New `EasyTable` properties
  * `lastRowWidget`
  * `onLastRowWidget`
  * `rowColor`
* New `EasyTableColumn` properties 
  * `cellBackground`
  * `cellOverflow`
* New theme properties
  * `CellThemeData.overflow`
  * `EasyTableThemeData.columnDividerFillHeight`
  * `HeaderCellThemeData.height`
  * `HeaderThemeData.color`
  * `HeaderThemeData.visible`
  * `RowThemeData.fillHeight`
  * `RowThemeData.hoverForeground`
  * `RowThemeData.lastDividerVisible`
  * `TableScrollbarThemeData.borderThickness`
  * `TableScrollbarThemeData.columnDividerColor`
  * `TableScrollbarThemeData.verticalOnlyWhenNeeded`
* Renamed
  * `ColumnSort.sortType` to `ColumnSort.order`
  * `EasyTable.multiSortEnabled` to `EasyTable.multiSort`
  * `EasyTable.onHoverListener` to `EasyTable.onHover`
  * `EasyTable.onLastVisibleRowListener` to `EasyTable.onLastVisibleRow`
  * `EasyTableModel.isRowsEmpty` to `EasyTableModel.isOriginalRowsEmpty`
  * `EasyTableModel.isRowsNotEmpty` to `EasyTableModel.isOriginalRowsNotEmpty`
  * `EasyTableModel.isVisibleRowsEmpty` to `EasyTableModel.isRowsEmpty`
  * `EasyTableModel.isVisibleRowsNotEmpty` to `EasyTableModel.isRowsNotEmpty`
  * `EasyTableModel.removeVisibleRowAt` to `EasyTableModel.removeRowAt`
  * `EasyTableModel.rowsLength` to `EasyTableModel.originalRowsLength`
  * `EasyTableModel.visibleRowAt` to `EasyTableModel.rowAt`
  * `EasyTableModel.visibleRowsLength` to `EasyTableModel.rowsLength`
  * `EasyTableSortType` to `TableSortOrder`
  * `RowThemeData.hoveredColor` to `RowThemeData.hoverBackground`
* Changed
  * `CellStyleBuilder` parameter `(ROW row)` to `(RowData<ROW> data)`
  * `EasyTableCellBuilder` parameters from `(ROW row, int rowIndex)` to `(RowData<ROW> data)`  
  * `EasyTableColumn.background` changed from `Color` to `CellBackgroundBuilder<ROW>`
  * `EasyTableColumnSort.pinned` bool to `EasyTableColumnSort.pinStatus` enum
* Moved
  * `EasyTable.cellContentHeight` to `CellThemeData.contentHeight`
* Removed
  * `CellIcon.alignment` (already exists on `CellStyle`)
  * `CellIcon.background` (already exists on `CellStyle`)
  * `EasyTableModel.allColumnsWidth`
  * `EasyTableModel.pinnedColumnsLength`
  * `EasyTableModel.pinnedColumnsWidth`
  * `EasyTableModel.unpinnedColumnsLength`
  * `EasyTableModel.unpinnedColumnsWidth`
  * `HeaderThemeData.height`
  
## 1.6.0

* Multiple column sort.
  * `EasyTableModel.removeColumnSort` renamed to `EasyTableModel.clearSort`. 
* Bugfix
  * `CellStyle.background` not being used in null-valued cells.

## 1.5.1

* Bugfix
  * Drag stops when horizontal scrollbar is displayed.

## 1.5.0

* Vertical scroll with keyboard keys: arrow up, arrow down, page down and page up.
* Added `visibleRowIndex` in `EasyTableCellBuilder`.
* Added `notifyUpdate` method in `EasyTableModel`.

## 1.4.0

* Feature to display horizontal scrollbar only when needed.
  * A warning is being displayed in the console due to a bug in Flutter: https://github.com/flutter/flutter/issues/103939
  * The error happens when the horizontal scrollbar is hidden after being visible.
  * The following MR should fix the issue: https://github.com/flutter/flutter/pull/103948 
* `EasyTable.onLastVisibleRowListener` for listening to the last visible row index.
  * Useful for infinite scroll. 
* Added `RowThemeData.dividerColor`.
* `EasyTableThemeData.rowDividerThickness` moved to `RowThemeData.dividerThickness`.
* `RowThemeData.columnDividerColor` moved to `EasyTableThemeData.columnDividerColor`.
* `TableScrollThemeData` renamed to `TableScrollbarThemeData`.
* `EasyTableThemeData.scroll` renamed to `EasyTableThemeData.scrollbar`.
* Removed `EasyTable.scrollbarMargin` and `EasyTable.scrollbarThickness` (already exists in `TableScrollbarThemeData`).

## 1.3.0

* Updated to Flutter 3.0.0 or higher.
* Improved renderer performance.
* `CellThemeData.contentHeight` moved to `EasyTable.cellContentHeight`.
* `EasyTableColumn`
  * Added the `iconValueMapper` and `cellStyleBuilder` attributes.
  * `textStyle` refactored to `headerTextStyle` and `cellTextStyle`.
  * `padding` refactored to `headerPadding` and `cellPadding`.
  * `alignment` to `headerAlignment` and `cellAlignment`.
* `EasyTableCell` has been removed.

## 1.2.0

* Scrollbars without overlapping table contents.
* Added the `onRowSecondaryTap` callback.

## 1.1.0

* Pinned columns.

## 1.0.0

* Header leading.

## 0.9.0

* `visibleRowsCount` feature to calculate the height based on the number of visible lines. It can be used within an unbounded height layout.
* Layout bugfix
* EasyTableModel
  * Adding the `replaceRows` method

## 0.8.0

* Columns fit.

## 0.7.0

* Theme
  * Column
    * Divider color
  * Cell
    * Null cell color
* New column parameters for theme override
  * `padding`
  * `alignment`
  * `textStyle`
* Allow mapping columns to null values

## 0.6.0

* Resizable columns.

## 0.5.0

* Row callbacks
  * `onRowTap`
  * `onRowDoubleTap`

## 0.4.0

* Sort feature.

## 0.3.0

* `EasyTableModel` to handle rows and columns.

## 0.2.0

* `EasyTableTheme` widget to applies a theme to descendant widgets.
  * More theming options will be added to `EasyTableThemeData`.

## 0.1.0

* Initial release
  * Bidirectional scroll bars
  * Columns
    * Initial width
    * Header builder
    * Cell builder
      * Initial automatic cell builder with data mapper

## 0.0.1

* Package creation.