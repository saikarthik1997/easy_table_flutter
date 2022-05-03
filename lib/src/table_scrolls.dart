import 'package:easy_table/src/internal/scroll_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class TableScrolls {
  factory TableScrolls(
      {ScrollController? unpinnedHorizontal,
      ScrollController? pinnedHorizontal,
      ScrollController? vertical}) {
    AreaScrolls pinnedArea = AreaScrolls(
        horizontal: pinnedHorizontal ?? EasyTableScrollController());
    AreaScrolls unpinnedArea = AreaScrolls(
        horizontal: unpinnedHorizontal ?? EasyTableScrollController());
    return TableScrolls._(
        pinnedArea: pinnedArea,
        unpinnedArea: unpinnedArea,
        vertical: vertical ?? EasyTableScrollController());
  }

  TableScrolls._(
      {required this.pinnedArea,
      required this.unpinnedArea,
      required ScrollController vertical})
      : _vertical = vertical {
    _addVerticalListeners();
  }

  final AreaScrolls pinnedArea;
  final AreaScrolls unpinnedArea;
  ScrollController _vertical;
  ScrollController get vertical => _vertical;
  set vertical(ScrollController vertical) {
    _removeVerticalListeners();
    _vertical = vertical;
    _addVerticalListeners();
  }

  void removeListeners() {
    _removeVerticalListeners();
    pinnedArea._removeHorizontalListeners();
    unpinnedArea._removeHorizontalListeners();
  }

  void _removeVerticalListeners() {
    _vertical.removeListener(_onVerticalChange);
    pinnedArea.contentVertical.removeListener(_onPinnedVerticalChange);
    unpinnedArea.contentVertical.removeListener(_onUnpinnedVerticalChange);
  }

  void _addVerticalListeners() {
    _vertical.addListener(_onVerticalChange);
    pinnedArea.contentVertical.addListener(_onPinnedVerticalChange);
    unpinnedArea.contentVertical.addListener(_onUnpinnedVerticalChange);
  }

  void _onVerticalChange() {
    if (_vertical.hasClients) {
      if (pinnedArea.contentVertical.hasClients) {
        pinnedArea.contentVertical.jumpTo(_vertical.offset);
      }
      if (unpinnedArea.contentVertical.hasClients) {
        unpinnedArea.contentVertical.jumpTo(_vertical.offset);
      }
    }
  }

  void _onPinnedVerticalChange() {
    if (pinnedArea.contentVertical.hasClients) {
      if (_vertical.hasClients) {
        _vertical.jumpTo(pinnedArea.contentVertical.offset);
      }
      if (unpinnedArea.contentVertical.hasClients) {
        unpinnedArea.contentVertical.jumpTo(pinnedArea.contentVertical.offset);
      }
    }
  }

  void _onUnpinnedVerticalChange() {
    if (unpinnedArea.contentVertical.hasClients) {
      if (_vertical.hasClients) {
        _vertical.jumpTo(unpinnedArea.contentVertical.offset);
      }
      if (pinnedArea.contentVertical.hasClients) {
        pinnedArea.contentVertical.jumpTo(unpinnedArea.contentVertical.offset);
      }
    }
  }
}

class AreaScrolls {
  AreaScrolls({required ScrollController horizontal})
      : _horizontal = horizontal {
    _addHorizontalListeners();
  }

  final ScrollController contentVertical = ScrollController();

  final ScrollController headerHorizontal = ScrollController();
  final ScrollController contentHorizontal = ScrollController();

  ScrollController _horizontal;
  ScrollController get horizontal => _horizontal;
  set horizontal(ScrollController horizontal) {
    _removeHorizontalListeners();
    _horizontal = horizontal;
    _addHorizontalListeners();
  }

  void _removeHorizontalListeners() {
    _horizontal.removeListener(_onHorizontalChange);
    headerHorizontal.removeListener(_onHeaderHorizontalChange);
    contentHorizontal.removeListener(_onContentHorizontalChange);
  }

  void _addHorizontalListeners() {
    _horizontal.addListener(_onHorizontalChange);
    headerHorizontal.addListener(_onHeaderHorizontalChange);
    contentHorizontal.addListener(_onContentHorizontalChange);
  }

  void _onHorizontalChange() {
    if (_horizontal.hasClients) {
      if (headerHorizontal.hasClients) {
        headerHorizontal.jumpTo(_horizontal.offset);
      }
      if (contentHorizontal.hasClients) {
        contentHorizontal.jumpTo(_horizontal.offset);
      }
    }
  }

  void _onHeaderHorizontalChange() {
    if (headerHorizontal.hasClients) {
      if (_horizontal.hasClients) {
        _horizontal.jumpTo(headerHorizontal.offset);
      }
      if (contentHorizontal.hasClients) {
        contentHorizontal.jumpTo(headerHorizontal.offset);
      }
    }
  }

  void _onContentHorizontalChange() {
    if (contentHorizontal.hasClients) {
      if (headerHorizontal.hasClients) {
        headerHorizontal.jumpTo(contentHorizontal.offset);
      }
      if (_horizontal.hasClients) {
        _horizontal.jumpTo(contentHorizontal.offset);
      }
    }
  }
}
