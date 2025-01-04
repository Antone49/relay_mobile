import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtonRepeat extends StatefulWidget {
  String? currentSvgImage;
  String? svgImage;
  String? svgImageTouched;
  String? svgImageUnconnected;
  bool isConnected = false;
  bool touched = false;

  double? height;
  double? width;
  Color? color;
  ColorFilter? colorFilter;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  VoidCallback? onTapStop;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  Timer? _timer;
  final int _repeatDuration = 100; // Duration in milliseconds

  ///a [CustomButtonRepeat] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomButtonRepeat({super.key,
    required this.isConnected,
    this.svgImage,
    this.svgImageTouched,
    this.svgImageUnconnected,
    this.height,
    this.width,
    this.color,
    this.colorFilter,
    this.fit,
    this.alignment,
    this.onTap,
    this.onTapStop,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  @override
  _CustomButtonRepeatState createState() => _CustomButtonRepeatState();
}

class _CustomButtonRepeatState extends State<CustomButtonRepeat> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Add the widget as an observer to listen to lifecycle events
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    widget._timer?.cancel();
    widget._timer = null;
    _handleTapStop();
    // Remove the observer when disposing the widget
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // Cancel the timer when the app is in the background
      widget._timer?.cancel();
      widget._timer = null;
      _handleTapStop();
    } else if (state == AppLifecycleState.resumed) {
      // Optionally, you could restart the timer or handle actions when the app resumes
      // But in this case, we don't need to restart the timer when the app comes back to the foreground.
    }
  }

  void _handleTap() {
    print('Tapped!');
    widget.onTap?.call();
    widget.touched = true;
    _changeImage();
  }

  void _handleTapStop() {
    print('Stop tap!');
    widget.onTapStop?.call();
    widget.touched = false;
    _changeImage();
  }

  void _startRepeating() {
    print('_startRepeating!');
    widget._timer ??= Timer.periodic(Duration(milliseconds: widget._repeatDuration), (timer) {
        if (mounted) {
          _handleTap();
        }
      });
  }

  void _stopRepeating() {
    print('_stopRepeating!');
    widget._timer?.cancel();
    widget._timer = null;
    _handleTapStop();
  }

  void _changeImage() {
    setState(() {
      if (widget.isConnected) {
        if (widget.touched) {
          widget.currentSvgImage = widget.svgImageTouched;
        }  else {
          widget.currentSvgImage = widget.svgImage;
        }
      }  else {
        widget.currentSvgImage = widget.svgImageUnconnected;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _changeImage();

    return widget.alignment != null ? Align(
      alignment: widget.alignment!,
      child: _buildWidget(),
    )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) { print('onTapDown'); _startRepeating(); },

        onTapUp: (TapUpDetails details) { print('onTapUp'); _stopRepeating(); },
        onLongPressEnd: (details) { print('onLongPressEnd'); _stopRepeating(); },
        onForcePressEnd: (details) { print('onPanEnd'); _stopRepeating(); },
        onHorizontalDragEnd: (details) { print('onHorizontalDragEnd'); _stopRepeating(); },
        onVerticalDragEnd: (details) { print('onVerticalDragEnd'); _stopRepeating(); },
        child: _buildCircleImage(),
      ),
    );
  }

  _buildCircleImage() {
    if (widget.radius != null) {
      return ClipRRect(
        borderRadius: widget.radius!,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  _buildImageWithBorder() {
    if (widget.border != null) {
      return Container(
        decoration: BoxDecoration(
          border: widget.border,
          borderRadius: widget.radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (widget.currentSvgImage != null && widget.currentSvgImage!.isNotEmpty) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: SvgPicture.asset(
          widget.currentSvgImage!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          colorFilter: widget.colorFilter,
        ),
      );
    }
    return const SizedBox();
  }
}
