import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LosIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const LosIcon({super.key, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? IconTheme.of(context).color ?? Colors.black;
    return SvgPicture.string(
      _losSvg,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );
  }
}

const String _losSvg = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="currentColor">
  <path d="m82-120 258-360h202l298-348v708H82Zm70-233-64-46 172-241h202l188-219 60 52-212 247H300L152-353Zm86 153h522v-412L578-400H380L238-200Zm522 0Z"/>
</svg>
''';
