import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtonRepeat extends StatefulWidget {
  ///[url] is required parameter for fetching network image
  String? url;

  ///[imagePath] is required parameter for showing png,jpg,etc image
  String? imagePath;

  ///[svgPath] is required parameter for showing svg image
  String? svgPath;

  ///[file] is required parameter for fetching image file
  File? file;

  double? height;
  double? width;
  Color? color;
  ColorFilter? colorFilter;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  Timer? _timer;
  final int _repeatDuration = 100; // Duration in milliseconds

  ///a [CustomButtonRepeat] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomButtonRepeat({super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.color,
    this.colorFilter,
    this.fit,
    this.alignment,
    this.onTap,
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
    } else if (state == AppLifecycleState.resumed) {
      // Optionally, you could restart the timer or handle actions when the app resumes
      // But in this case, we don't need to restart the timer when the app comes back to the foreground.
    }
  }

  void _handleTap() {
    print('Tapped!');
    widget.onTap?.call();
  }

  void _startRepeating(TapDownDetails details) {
    widget._timer = Timer.periodic(Duration(milliseconds: widget._repeatDuration), (timer) {
      if (mounted) {
        _handleTap();
      }
    });
  }

  void _stopRepeating(TapUpDetails details) {
    widget._timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
      alignment: widget.alignment!,
      child: _buildWidget(),
    )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) => _startRepeating(details),
        onTapUp: (TapUpDetails details) => _stopRepeating(details),
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
    if (widget.svgPath != null && widget.svgPath!.isNotEmpty) {
      return SizedBox(
        height: widget.height,
        width: widget.width,
        child: SvgPicture.asset(
          widget.svgPath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          colorFilter: widget.colorFilter,
        ),
      );
    } else if (widget.file != null && widget.file!.path.isNotEmpty) {
      return Image.file(
        widget.file!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        color: widget.color,
      );
    } else if (widget.url != null && widget.url!.isNotEmpty) {
      return CachedNetworkImage(
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        imageUrl: widget.url!,
        color: widget.color,
        placeholder: (context, url) => SizedBox(
          height: 30,
          width: 30,
          child: LinearProgressIndicator(
            color: Colors.grey.shade200,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          widget.placeHolder,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.cover,
        ),
      );
    } else if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      return Image.asset(
        widget.imagePath!,
        height: widget.height,
        width: widget.width,
        fit: widget.fit ?? BoxFit.cover,
        color: widget.color,
      );
    }
    return const SizedBox();
  }
}
