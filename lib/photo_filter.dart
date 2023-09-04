import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_filter_pro/apply_filter_params.dart';

import 'filter_manager.dart';
import 'named_color_filter.dart';

const double midBrightness = 0.627;
const double midContrast = 0.996;
const double midSaturation = 1.8;

/// A widget that allows users to apply color filters to an image.
@immutable
class PhotoFilter extends StatefulWidget {
  /// The image to which filters will be applied.
  final File image;

  /// A list of named color filters as preset filters.
  final List<NamedColorFilter> presets;

  /// The icon data for the cancel button.
  final IconData cancelIcon;

  /// The icon data for the apply button.
  final IconData applyIcon;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// The color of the sliders used to adjust filter parameters.
  final Color? sliderColor;

  /// The text style for the labels of the sliders.
  final TextStyle? sliderLabelStyle;

  /// The text style for labels on the bottom buttons (e.g., "Presets" and "Manual").
  final TextStyle? bottomButtonsTextStyle;

  /// The text style for the labels of the presets
  final TextStyle? presetsLabelTextStyle;

  /// The text style for the message displayed while filters are being applied.
  final TextStyle? applyingTextStyle;

  /// The call back when tapping on the cancel icon.
  final VoidCallback? onCancel;

  /// The call back when isolate starts to apply filter and generate new Image.
  final VoidCallback? onStartApplyingFilter;

  /// The call back when applying filter is finished to apply filter and generate new Image.
  final void Function(File?)? onFinishApplyingFilter;

  /// The boolean if image has to be compressed when applying filter.
  final bool compressImage;

  /// The value of the quality for compressing the image.
  final int? compressQuality;

  /// Creates a new ImageFilterWidget instance.
  ///
  /// The [image] parameter specifies the image to which filters will be applied.
  ///
  /// The [presets] parameter is a list of NamedColorFilter objects representing
  /// the available filters that the user can choose from.
  ///
  /// The [cancelIcon] parameter provides the icon data for the cancel button,
  /// allowing users to discard filter changes and close the widget.
  ///
  /// The [applyIcon] parameter provides the icon data for the apply button,
  /// allowing users to confirm and apply the selected filters to the image.
  ///
  /// The [backgroundColor] parameter defines the background color of the widget.
  ///
  /// The [sliderColor] parameter sets the color of sliders used for adjusting
  /// filter parameters.
  ///
  /// The [sliderLabelStyle] parameter defines the text style used for labels
  /// displayed next to sliders.
  ///
  /// The [bottomButtonsTextStyle] parameter defines the text style for labels
  /// appearing on the bottom buttons, such as "Cancel" and "Apply".
  ///
  /// The [presetsLabelTextStyle] parameter sets the text style for labels
  /// displaying filter names above the respective sliders.
  ///
  /// The [applyingTextStyle] parameter defines the text style for the message
  /// that appears while filters are being applied to the image.
  ///
  /// The [onCancel] parameter defines the call back action
  /// to trigger when tapping on the cancel icon. By default this pops the page.
  ///
  /// The [onStartApplyingFilter] parameter defines the call back action
  /// to trigger when tapping on the apply/submit icon.
  ///
  /// The [onFinishApplyingFilter] parameter defines the call back action
  /// to trigger when applying the filter is done.
  ///
  /// The [compressImage] parameter defines if the image should be compressed
  /// while applying filter to reduce size.
  ///
  /// The [compressQuality] parameter defines the quality of the image
  /// after compressing it. Higher number results in bigger file size.
  /// default value is 75 if compressImage is true.
  ///
  const PhotoFilter(
      {super.key,
      required this.image,
      this.presets = defaultColorFilters,
      required this.cancelIcon,
      required this.applyIcon,
      this.backgroundColor = Colors.black,
      this.sliderColor,
      this.sliderLabelStyle,
      this.bottomButtonsTextStyle,
      this.presetsLabelTextStyle,
      this.applyingTextStyle,
      this.onCancel,
      this.onStartApplyingFilter,
      this.onFinishApplyingFilter,
      this.compressImage = false,
      this.compressQuality});

  @override
  _PhotoFilterState createState() => _PhotoFilterState();
}

class _PhotoFilterState extends State<PhotoFilter> {
  NamedColorFilter? _selectedFilter;
  NamedColorFilter? _previousSelectedFilter;
  bool _showPreset = true;
  bool _showSliders = false;
  bool _isApplying = false;
  Timer? _timer;
  double _brightness = midBrightness;
  double _contrast = midContrast;
  double _saturation = midSaturation;
  List<double>? _previousColorMatrix;

  List<double> _colorMatrix = [
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _selectedFilter = widget.presets.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              _topButtons(context),
              const SizedBox(height: 8),
              _mainImage(),
              const SizedBox(height: 8),
              if (_showSliders) ...[
                _buildSlider("Brightness", midBrightness - 0.4, midBrightness + 0.4, _brightness, (value) {
                  _brightness = value;
                }),
                _buildSlider("Contrast", midContrast - 0.0035, midContrast + 0.0035, _contrast, (value) {
                  _contrast = value;
                }),
                _buildSlider("Saturation", midSaturation - 2.0, midSaturation + 2.0, _saturation, (value) {
                  _saturation = value;
                }),
              ],
              if (_showPreset) ...[
                _presets(),
              ],
              const SizedBox(
                height: 8,
              ),
              _bottomButtons(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
          if (_isApplying) ...[
            SizedBox.fromSize(
                size: MediaQuery.sizeOf(context),
                child: Container(
                  color: Colors.black.withOpacity(.9),
                  child: Center(
                      child: Text(
                        "Applying filter...",
                        style: widget.applyingTextStyle ?? const TextStyle(color: Colors.grey, fontSize: 13),
                      )),
                ))
          ]
        ],
      ),
    );
  }

  Row _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (_showPreset) {
              return;
            }
            setState(() {
              _showSliders = false;
              _showPreset = true;
            });
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Presets",
                  textAlign: TextAlign.center,
                  style: widget.bottomButtonsTextStyle?.copyWith(fontWeight: _showPreset ? FontWeight.bold : FontWeight.w400))),
        ),
        InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (_showSliders) {
                return;
              }
              setState(() {
                _showSliders = true;
                _showPreset = false;
              });
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text("Manual",
                    textAlign: TextAlign.center,
                    style: widget.bottomButtonsTextStyle?.copyWith(fontWeight: _showSliders ? FontWeight.bold : FontWeight.w400)))),
      ],
    );
  }

  SizedBox _presets() {
    return SizedBox(
      height: 161,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.presets.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ColorFiltered(
                  colorFilter: widget.presets[index].colorFilterMatrix.isEmpty
                      ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                      : ColorFilter.matrix(widget.presets[index].colorFilterMatrix),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                    ),
                    width: 72,
                    height: 16,
                    child: Center(
                      child: Text(
                        widget.presets[index].name,
                        style: widget.presetsLabelTextStyle ?? const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = widget.presets[index];
                      _previousSelectedFilter = widget.presets[index];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ColorFiltered(
                      colorFilter: widget.presets[index].colorFilterMatrix.isEmpty
                          ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                          : ColorFilter.matrix(widget.presets[index].colorFilterMatrix),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                          child: Image.file(
                            widget.image,
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded _mainImage() {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) {
          _timer = Timer(
            const Duration(milliseconds: 350),
                () {
              setState(() {
                _selectedFilter = widget.presets.first;
                _colorMatrix = [
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0,
                ];
              });
            },
          );
        },
        onTapUp: (_) {
          _timer?.cancel();
          setState(() {
            _selectedFilter = _previousSelectedFilter ?? widget.presets[0];
            _colorMatrix = _previousColorMatrix ?? _colorMatrix;
          });
        },
        child: ColorFiltered(
          colorFilter: _selectedFilter!.colorFilterMatrix.isEmpty
              ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
              : ColorFilter.matrix(_selectedFilter!.colorFilterMatrix),
          child: ColorFiltered(
            colorFilter: ColorFilter.matrix(_colorMatrix),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Image.file(
                widget.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _topButtons(BuildContext context) {
    return Container(
      height: 72,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  widget.onCancel?.call();
                  Navigator.of(context).pop(null);
                },
                icon: Icon(
                  widget.cancelIcon,
                  color: Colors.white,
                  size: 28,
                )),
            IconButton(
                onPressed: () async {
                  if (_selectedFilter!.name == 'None') {
                    widget.onFinishApplyingFilter?.call(null);
                    Navigator.of(context).pop();
                    return;
                  }
                  widget.onStartApplyingFilter?.call();
                  if(widget.onFinishApplyingFilter != null){
                    Navigator.of(context).pop();
                  }else {
                    setState(() {
                      _isApplying = true;
                    });
                  }
                  Isolate? _newIsolate;

                  final ReceivePort _receivePort = ReceivePort();
                  _newIsolate = await Isolate.spawn(
                      _applyFilter,
                      ApplyFilterParams(
                          shouldCompress: widget.compressImage,
                          compressQuality: widget.compressQuality,
                          rootIsolateToken: RootIsolateToken.instance!,
                          rawFile: widget.image,
                          colorMatrix: _selectedFilter!.colorFilterMatrix,
                          brightness: _brightness,
                          contrast: _contrast,
                          saturation: _saturation,
                          defaultMatrix: _colorMatrix,
                          sendPort: _receivePort.sendPort));

                  _receivePort.listen((message) {
                    if (message != null) {
                      widget.onFinishApplyingFilter?.call(message);
                      if(context.mounted){
                        Navigator.of(context).pop(message);
                      }
                    }
                    _newIsolate?.kill(priority: Isolate.immediate);
                    _newIsolate = null;
                  });
                },
                icon: Icon(
                  widget.applyIcon,
                  color: Colors.white,
                  size: 28,
                )),
          ],
        ),
      ),
    );
  }

  static void _applyFilter(ApplyFilterParams applyFilterParams) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(applyFilterParams.rootIsolateToken);
    File filteredImageFile = await FilterManager.applyFilter(applyFilterParams);
    applyFilterParams.sendPort.send(filteredImageFile);
  }

  List<double> _generateColorMatrix() {
    var brightness = _brightness;
    final List<double> brightnessMatrix = [
      brightness, 0, 0, 0, 0,
      0, brightness, 0, 0, 0,
      0, 0, brightness, 0,
      0, 0, 0, 0, 1, 0,
    ];
    var contrast = 1.9949 - _contrast;

    final List<double> contrastMatrix = [
      contrast, 0, 0, 0, 128 * (1 - contrast),
      0, contrast, 0, 0, 128 * (1 - contrast),
      0, 0, contrast, 0, 128 * (1 - contrast),
      0, 0, 0, 1, 0,
    ];

    var saturation = _saturation;

    final List<double> saturationMatrix = [
      0.213 + 0.787 * saturation, 0.715 - 0.715 * saturation, 0.072 - 0.072 * saturation, 0, 0, 0.213 - 0.213 * saturation,
      0.715 + 0.285 * saturation, 0.072 - 0.072 * saturation, 0, 0, 0.213 - 0.213 * saturation, 0.715 - 0.715 * saturation,
      0.072 + 0.928 * saturation, 0, 0, 0,
      0, 0, 1, 0,
    ];


    var result = _multiplyMatrices(brightnessMatrix, contrastMatrix);
    result = _multiplyMatrices(result, saturationMatrix);
    return result;
  }

  List<double> _multiplyMatrices(List<double> a, List<double> b) {
    if (a.length != 20 || b.length != 20) {
      throw ArgumentError('Both matrices must be of size 20.');
    }

    var result = List<double>.filled(20, 0);

    for (var y = 0; y < 4; y++) {
      for (var x = 0; x < 5; x++) {
        var sum = 0.0;
        for (var z = 0; z < 4; z++) {
          sum += a[y * 5 + z] * b[z * 5 + x];
        }
        if (x < 4) {
          sum += a[y * 5 + 4];
        }
        result[y * 5 + x] = sum;
      }
    }

    return result;
  }

  Widget _buildSlider(String label, double min, double max, double value, Function onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  switch (label) {
                    case "Brightness":
                      _brightness = midBrightness;
                      break;
                    case "Contrast":
                      _contrast = midContrast;
                      break;
                    case "Saturation":
                      _saturation = midSaturation;
                      break;
                  }
                  _colorMatrix = _generateColorMatrix();
                  _previousColorMatrix = _colorMatrix;
                });
              },
              child: Text(label, style: widget.sliderLabelStyle)),
          Center(
            child: SizedBox(
              height: 40,
              child: Slider.adaptive(
                activeColor: widget.sliderColor,
                value: value,
                onChanged: (value) {
                  onChanged(value);
                  setState(() {
                    _colorMatrix = _generateColorMatrix();
                    _previousColorMatrix = _colorMatrix;
                  });
                },
                min: min,
                max: max,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
