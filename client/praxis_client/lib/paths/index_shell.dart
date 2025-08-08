import 'package:shadcn_flutter/shadcn_flutter.dart';
import "package:go_router/go_router.dart";

class IndexShell extends StatefulWidget {
  const IndexShell({super.key, required this.child});

  final Widget child;

  @override
  State<IndexShell> createState() => _IndexShellState();
}

class _IndexShellState extends State<IndexShell> {
  int selected = 0;

  NavigationBarItem buildButton(String label, IconData icon) {
    return NavigationItem(label: Text(label), child: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final isWideLayout = MediaQuery.of(context).size.width >= 600;

    if (isWideLayout) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationRail(
            index: selected,
            expanded: true,
            onSelected: (index) {
              setState(() {
                selected = index;
              });
              context.go("/bills");
            },
            children: [
              buildButton('Home', BootstrapIcons.house),
              buildButton('Explore', BootstrapIcons.compass),
              buildButton('Library', BootstrapIcons.musicNoteList),
              const NavigationDivider(),
              const NavigationLabel(child: Text('Settings')),
              buildButton('Profile', BootstrapIcons.person),
              buildButton('App', BootstrapIcons.appIndicator),
              const NavigationDivider(),
              const NavigationGap(12),
              const NavigationWidget(child: FlutterLogo()),
            ],
          ),
          Expanded(child: widget.child),
        ],
      );
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: widget.child),
          NavigationBar(
            onSelected: (index) {
              setState(() {
                selected = index;
              });
              context.go("/bills")
            },
            index: selected,
            children: [
              buildButton('Home', BootstrapIcons.house),
              buildButton('Explore', BootstrapIcons.compass),
              buildButton('Library', BootstrapIcons.musicNoteList),
              buildButton('Profile', BootstrapIcons.person),
              buildButton('App', BootstrapIcons.appIndicator),
            ],
          ),
        ],
      ),
    );
  }
}
