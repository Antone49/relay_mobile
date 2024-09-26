import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/color_constant.dart';

class CustomInputQuantity extends StatefulWidget {
  
  final num maxVal;
  final num value;
  final num minVal;
  final num steps;
  final ValueChanged<int> onQuantityChanged;
  final bool isIntrinsicWidth;
  final InputDecoration? textFieldDecoration;
  final Color btnColor1;
  final Color btnColor2;
  final double? splashRadius;

  const CustomInputQuantity({
    Key? key,
    this.value = 1,
    this.splashRadius,
    this.textFieldDecoration,
    this.isIntrinsicWidth = true,
    required this.onQuantityChanged,
    this.maxVal = 100,
    this.minVal = 0,
    this.steps = 1,
    this.btnColor1 = ColorConstant.primary,
    this.btnColor2 = ColorConstant.gray,
  }) : super(key: key);

  @override
  State<CustomInputQuantity> createState() => CustomInputQuantityState();
}

class CustomInputQuantityState extends State<CustomInputQuantity> {
  /// text controller of textfield
  TextEditingController _valCtrl = TextEditingController();

  /// current value of quantity
  /// late num value;
  late ValueNotifier<num?> currentVal;

  /// [InputDecoration] use for [TextFormField]
  /// use when [textFieldDecoration] not null
  final _inputDecoration = const InputDecoration(
    border: UnderlineInputBorder(),
    isDense: true,
    contentPadding: kIsWeb ? EdgeInsets.only(bottom: 4) : null,
    isCollapsed: true,
  );

  @override
  void initState() {
    currentVal = ValueNotifier(widget.value);
    _valCtrl = TextEditingController(text: "${widget.value}");
    super.initState();
  }

  void plus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.value;
    value += widget.steps;

    if (value >= widget.maxVal) {
      value = widget.maxVal;
    }

    onQtyChanged(num.tryParse(value.toString()));
  }

  void minus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.value;
    value -= widget.steps;
    if (value <= widget.minVal) {
      value = widget.minVal;
    }

    onQtyChanged(num.tryParse(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    if(currentVal.value != widget.value) {
      onQtyChanged(widget.value, emit: false);
    }

    if (currentVal.value == null || currentVal.value == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        alignment: Alignment.centerRight,
        child: BuildBtn(
          isPlus: true,
          onChanged: () => onQtyChanged(1),
          splashRadius: widget.splashRadius,
        ),
      );
    }

    return widget.isIntrinsicWidth ? IntrinsicWidth(child: _buildInputQty()) : _buildInputQty();
  }

  /// build widget input quantity
  Widget _buildInputQty() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder<num?>(
                    valueListenable: currentVal,
                    builder: (context, value, child) {
                      bool limitBtmState = (value ?? widget.value) > widget.minVal;
                      return BuildBtn(
                        btnColor: limitBtmState ? widget.btnColor1 : widget.btnColor2,
                        isPlus: false,
                        splashRadius: widget.splashRadius,
                        onChanged: limitBtmState ? minus : null,
                      );
                    }),
                const SizedBox(
                  width: 2,
                ),
                Expanded(child: _buildtextfield()),
                const SizedBox(
                  width: 2,
                ),
                ValueListenableBuilder<num?>(
                    valueListenable: currentVal,
                    builder: (context, value, child) {
                      bool limitTopState = (value ?? widget.value) < widget.maxVal;

                      return BuildBtn(
                        btnColor: limitTopState ? widget.btnColor1 : widget.btnColor2,
                        isPlus: true,
                        onChanged: limitTopState ? plus : null,
                        splashRadius: widget.splashRadius,
                      );
                    }),
              ],
            ),
          ),
        ],
      );

  /// widget textformfield
  Widget _buildtextfield() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: widget.textFieldDecoration ?? _inputDecoration,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          controller: _valCtrl,
          onChanged: (String strVal) {
            num? temp = num.tryParse(_valCtrl.text);
            if (temp == null) return;
            if (temp > widget.maxVal) {
              temp = widget.maxVal;
              _valCtrl.text = "${widget.maxVal}";
            } else if (temp <= widget.minVal) {
              temp = widget.minVal;
              _valCtrl.text = temp.toString();
            }

            num? newVal = num.tryParse(_valCtrl.text);
            onQtyChanged(newVal);
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            // LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp(r"^\d*\.??\d*")),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _valCtrl.dispose();
  }

  onQtyChanged(val, {bool emit = true}) {
    /// set back to the controller
    _valCtrl.text = "$val";
    currentVal.value = val;

    /// move cursor to the right side
    _valCtrl.selection = TextSelection.fromPosition(TextPosition(offset: _valCtrl.text.length));

    if (val != null && emit) {
      // Problem : call the function during the build time
      widget.onQuantityChanged(val as int);
    }
  }
}

class BuildBtn extends StatelessWidget {
  final Function()? onChanged;
  final bool isPlus;
  final Color btnColor;
  final double? splashRadius;

  const BuildBtn(
      {super.key, this.splashRadius, required this.isPlus, this.onChanged, this.btnColor = ColorConstant.primary});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: btnColor,
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      onPressed: onChanged,
      disabledColor: btnColor,
      splashRadius: splashRadius ?? 16,
      icon: Icon(isPlus ? Icons.add_circle : Icons.remove_circle),
    );
  }
}
