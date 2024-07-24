import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/commands/core/app_spacing.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/app_dropdown.types.dart';
import 'package:myapp/shared/widgets/app_dropdown.dart/dropdown_model.dart';

class CustomDropdown2<T> extends StatefulWidget {
  /// the child widget for the button, this will be ignored if text is supplied
  final Widget child;

  final ScrollController? scrollController;

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(DropDownModel)? onChange;

  /// list of DropdownItems
  final List<DropdownItem2<T>> items;
  final DropdownStyle2 dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle2 dropdownButtonStyle;

  /// dropdown button icon defaults to caret
  final Widget? icon;
  final bool hideIcon;

  final bool thumbVisibility;

  /// if true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;

  const CustomDropdown2({
    Key? key,
    this.hideIcon = false,
    this.thumbVisibility = true,
    required this.child,
    required this.items,
    this.scrollController,
    this.dropdownStyle = const DropdownStyle2(),
    this.dropdownButtonStyle = const DropdownButtonStyle2(),
    this.icon,
    this.leadingIcon = false,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomDropdown2> createState() => _CustomDropdown2State();
}

class _CustomDropdown2State<T> extends State<CustomDropdown2<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    autoClosePopUp();
  }

  autoClosePopUp() {
    if (widget.scrollController == null) return;
    widget.scrollController?.addListener(() {
      if (_isOpen) {
        _toggleDropdown(close: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    // link the overlay to the button

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: Container(
              width: style.width,
              height: style.height,
              padding: style.padding,
              decoration: BoxDecoration(
                  color: style.backgroundColor,
                  borderRadius: style.borderRadius ??
                      const BorderRadius.all(Radius.circular(AppSpacing.x25))),
              child: Row(
                mainAxisAlignment:
                    style.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
                textDirection:
                    widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.child,
                  if (!widget.hideIcon)
                    widget.icon ??
                        RotationTransition(
                          turns: _rotateAnimation,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: RotatedBox(
                              quarterTurns: 4,
                              child: SvgPicture.asset(
                                Assets.svg.dropdown,
                                width: AppSpacing.x20,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = (widget.dropdownStyle.offset == null
            ? 544
            : widget.dropdownStyle.offset!.dy) +
        size.height +
        5;
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle.width ?? size.width,
                child: CompositedTransformFollower(
                  offset:
                      widget.dropdownStyle.offset ?? Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle.elevation ?? 0,
                    color: widget.dropdownStyle.color ?? AppColors.grey3Light,
                    shape: widget.dropdownStyle.shape,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle.constraints ??
                            BoxConstraints(
                              maxHeight: (MediaQuery.of(context).size.height -
                                          topOffset -
                                          15)
                                      .isNegative
                                  ? 100
                                  : MediaQuery.of(context).size.height -
                                      topOffset -
                                      15,
                            ),
                        child: RawScrollbar(
                          thumbVisibility: widget.thumbVisibility,
                          thumbColor: widget.dropdownStyle.scrollbarColor ??
                              Colors.grey,
                          controller: _scrollController,
                          child: ListView(
                            padding:
                                widget.dropdownStyle.padding ?? EdgeInsets.zero,
                            shrinkWrap: true,
                            controller: _scrollController,
                            children: widget.items.asMap().entries.map((item) {
                              final result =
                                  item.value.value as AppDropdownItem;
                              final response = DropDownModel(
                                  name: result.label,
                                  index: item.key,
                                  flag: result.flag,
                                  id: result.key.contains('null')
                                      ? 0
                                      : int.parse(result.key));
                              return InkWell(
                                onTap: widget.onChange != null
                                    ? () {
                                        widget.onChange!(response);
                                        _toggleDropdown();
                                      }
                                    : null,
                                child: item.value,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (widget.onChange == null) return;
    Get.focusScope?.unfocus();
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

class DropdownItem2<T> extends StatelessWidget {
  final T? value;
  final Widget child;

  const DropdownItem2({Key? key, this.value, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
