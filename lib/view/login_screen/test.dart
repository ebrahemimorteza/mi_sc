import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PathGame extends StatefulWidget {
  const PathGame({super.key});

  @override
  State<PathGame> createState() => _PathGameState();
}

class _PathGameState extends State<PathGame> {
  Offset? _charPos;
  late Path _path;
  late ui.PathMetric _metric;
  double _progress = 0.0;
  ui.Image? patternImage;

  bool usePattern = false; // false = Gradient, true = Pattern

  @override
  void initState() {
    super.initState();
    _loadPath();
    _loadPattern();
  }

  void _loadPath() {
    _path = Path()
      ..moveTo(50, 500)
      ..lineTo(50, 100)
      ..lineTo(200, 500)
      ..lineTo(350, 100)
      ..lineTo(350, 500);

    _metric = _path.computeMetrics().first;
  }

  Future<void> _loadPattern() async {
    final data = await rootBundle.load("assets/pattern.png"); // مثلا پلنگی
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      patternImage = frame.image;
    });
  }

  void _updateFinger(Offset finger) {
    double closestDist = double.infinity;
    Offset? closestPoint;
    double closestT = 0;

    for (double t = 0; t < _metric.length; t += 5) {
      final pos = _metric.getTangentForOffset(t)!.position;
      final dist = (pos - finger).distance;
      if (dist < closestDist) {
        closestDist = dist;
        closestPoint = pos;
        closestT = t;
      }
    }

    if (closestDist < 30) {
      setState(() {
        _charPos = closestPoint;
        _progress = closestT / _metric.length;
      });
    } else {
      setState(() {
        _charPos = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Path Game M"),
        actions: [
          Switch(
            value: usePattern,
            onChanged: (val) => setState(() => usePattern = val),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          RenderBox box = context.findRenderObject() as RenderBox;
          Offset localPos = box.globalToLocal(details.globalPosition);
          _updateFinger(localPos);
        },
        onPanEnd: (_) => setState(() => _charPos = null),
        child: CustomPaint(
          size: Size.infinite,
          painter: MPathPainter(
            path: _path,
            progress: _progress,
            charPos: _charPos,
            usePattern: usePattern,
            patternImage: patternImage,
          ),
        ),
      ),
    );
  }
}

class MPathPainter extends CustomPainter {
  final Path path;
  final double progress;
  final Offset? charPos;
  final bool usePattern;
  final ui.Image? patternImage;

  MPathPainter({
    required this.path,
    required this.progress,
    this.charPos,
    required this.usePattern,
    this.patternImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // مسیر کامل (پس‌زمینه خاکستری)
    final paintBg = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paintBg);

    if (progress > 0) {
      final metrics = path.computeMetrics().first;
      final length = metrics.length * progress;
      final extractedPath = metrics.extractPath(0, length);

      Paint paintProgress;

      if (usePattern && patternImage != null) {
        // استفاده از تصویر پترن
        paintProgress = Paint()
          ..shader = ImageShader(
            patternImage!,
            TileMode.repeated,
            TileMode.repeated,
            Matrix4.identity().storage,
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;
      } else {
        // استفاده از گرادینت رنگین‌کمانی
        paintProgress = Paint()
          ..shader = LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.purple,
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;
      }

      canvas.drawPath(extractedPath, paintProgress);
    }

    // کاراکتر (دایره آبی)
    if (charPos != null) {
      final paintChar = Paint()..color = Colors.blue;
      canvas.drawCircle(charPos!, 15, paintChar);
    }
  }

  @override
  bool shouldRepaint(covariant MPathPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.charPos != charPos ||
        oldDelegate.usePattern != usePattern ||
        oldDelegate.patternImage != patternImage;
  }
}