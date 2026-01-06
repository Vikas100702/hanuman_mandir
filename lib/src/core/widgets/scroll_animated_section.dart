import 'package:flutter/material.dart';

class ScrollAnimatedSection extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration duration;
  final double
  offset; // trigger animation when item is this pixels up from bottom

  const ScrollAnimatedSection({
    super.key,
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 1000),
    this.offset = 50.0,
  });

  @override
  State<ScrollAnimatedSection> createState() => _ScrollAnimatedSectionState();
}

class _ScrollAnimatedSectionState extends State<ScrollAnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool isRevealed = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    // Slide up effect (Sattvic motion - smooth and rising)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Starts slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    // Listen to scroll changes
    widget.scrollController.addListener(_checkVisibility);

    // Check visibility immediately after first layout (for top items like Header)
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (isRevealed || !mounted) return;

    final RenderObject? renderObject = _key.currentContext?.findRenderObject();
    if (renderObject == null) return;

    final RenderBox box = renderObject as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    final double screenHeight = MediaQuery.of(context).size.height;

    // Trigger when the top of the widget enters the bottom of the screen
    // adjusting by 'offset' to make it appear slightly before full view
    if (position.dy < screenHeight - widget.offset) {
      _controller.forward();
      setState(() {
        isRevealed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(position: _slideAnimation, child: widget.child),
      ),
    );
  }
}
