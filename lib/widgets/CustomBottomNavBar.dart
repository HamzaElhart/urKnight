import 'package:flutter/material.dart';

class Custombottomnavbar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const Custombottomnavbar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustombottomnavbarState createState() => _CustombottomnavbarState();
}

class _CustombottomnavbarState extends State<Custombottomnavbar> {
  List<bool> _isHovered = List.generate(5, (_) => false);

  void _onHover(int index, bool isHovered) {
    setState(() {
      _isHovered[index] = isHovered;
    });
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = widget.selectedIndex == index;
    bool isHovered = _isHovered[index];

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: MouseRegion(
        onEnter: (_) => _onHover(index, true),
        onExit: (_) => _onHover(index, false),
        child: Container(
          width: 70,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xFF09943C) // Selected background color
                    : (isHovered
                        ? const Color(0xFFD9D9D9) // Hovered background color
                        : Colors.transparent),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color:
                    isSelected
                        ? Colors.white
                        : (isHovered ? Colors.black : const Color(0xFF313A51)),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color:
                      isSelected
                          ? Colors.white
                          : (isHovered
                              ? Colors.black
                              : const Color(0xFF313A51)),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: const Color(0xFFF5F5FA), // Background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home, 'Home'),
          _buildNavItem(1, Icons.contacts, 'Contacts'),
          _buildNavItem(2, Icons.explore, 'Explore'),
          _buildNavItem(3, Icons.tv, 'Watch'),
          _buildNavItem(4, Icons.account_circle, 'Profile'),
        ],
      ),
    );
  }
}
