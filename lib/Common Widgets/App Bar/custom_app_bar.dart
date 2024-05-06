import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  final GlobalKey<ScaffoldState>? drawerKey;

  final Color? appBarBGColor;
  final VoidCallback? leadingLink;
  final Widget? leadingChild;
  final Widget? titleChild;

  final List<Widget>? actionsWidget;
  final bool? centerTitle;
  const CustomAppBar(
      {Key? key, this.appBarBGColor, this.leadingLink, this.leadingChild, this.titleChild, this.actionsWidget, this.drawerKey, this.centerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: appBarBGColor,
      leading: leadingChild != null
          ? Align(
              alignment: Alignment.center,
              child: InkWell(
                highlightColor: Colors.transparent,
                onTap: leadingLink,
                child: leadingChild,
              ),
            )
          : null,
      title: titleChild,
      actions: actionsWidget,
      centerTitle: centerTitle,
    );
  }
}
