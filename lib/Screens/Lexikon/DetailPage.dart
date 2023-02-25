import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Icon titleIcon;
  final String titleText;
  final String textContent;

  const DetailPage({
    required this.titleIcon,
    required this.titleText,
    required this.textContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(titleText,
                      style: Theme.of(context).textTheme.titleLarge),
                  centerTitle: true,
                  background: topContent(
                      titleIcon: titleIcon,
                      titleText: titleText,
                      context: context),
                )))
      ],
      body: Column(
        children: [
          bottomContent(context: context, textContent: textContent),
        ],
      ),
    );
  }
}

class topContent extends StatelessWidget {
  Icon titleIcon;
  String titleText;
  topContent({
    required this.titleIcon,
    required this.titleText,
    @required context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Background
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/lexicon/whatis/barfbanner.webp")))),
      // Opacity
      // Opacity(
      //   opacity: 0.7,
      //   child: Container(
      //     decoration:
      //         BoxDecoration(color: Theme.of(context).colorScheme.background),
      //   ),
      // )
    ]);
  }
}

class bottomContent extends StatelessWidget {
  String textContent;
  bottomContent({
    @required context,
    required this.textContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, bottom: 25, top: 130),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            textContent,
            style: TextStyle(fontSize: 21),
          ),
        ),
      ),
    );
  }
}
