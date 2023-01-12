import 'package:flutter/material.dart';

class HomepageTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final String route;

  const HomepageTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.route,
  });

  @override
  State<HomepageTile> createState() => _HomepageTileState();
}

class _HomepageTileState extends State<HomepageTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.route);
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovering = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovering ? Colors.grey[200] : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (widget.image != "")
                Image.asset(
                  widget.image,
                  height: 100,
                ),
              SizedBox(height: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
