import 'package:flutter/material.dart';
import 'package:flutter_news/pages/datail/detail_page.dart';
import 'package:flutter_news/repository/notice/model/notice.dart';
import 'package:flutter_news/support/util/fade_in_route.dart';
import 'package:flutter_news/support/util/functions.dart';

import 'page_transformer.dart';

class HighlightWidget extends StatelessWidget {
  HighlightWidget({
    required this.item,
    required this.pageVisibility,
  });

  final Notice item;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    required double translationFactor,
    required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return new Opacity(
      opacity: pageVisibility.visibleFraction,
      child: new Transform(
        alignment: FractionalOffset.topLeft,
        transform: new Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: new Text(
        item.category,
        style: textTheme.caption?.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    final titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: new Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new Text(
          item.title,
          style: textTheme.headline6?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return new Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  Widget _getImageNetwork(url) {
    try {
      if (url != '') {
        return ClipRRect(
          borderRadius: new BorderRadius.circular(8.0),
          child: new FadeInImage.assetNetwork(
            placeholder: 'assets/place_holder.jpg',
            image: url,
            fit: BoxFit.cover,
            alignment: new FractionalOffset(
              0.5 + (pageVisibility.pagePosition / 3),
              0.5,
            ),
          ),
        );
      } else {
        return new Image.asset('assets/place_holder_2.jpg');
      }
    } catch (e) {
      return new Image.asset('assets/place_holder_2.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: new Material(
        elevation: 4.0,
        borderRadius: new BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () {
            openDetail(context);
          },
          child: new Stack(
            fit: StackFit.expand,
            children: [
              new Hero(
                  tag: item.title,
                  child: _getImageNetwork(
                      Functions.getImgResizeUrl(item.img, 400, ''))),
              _getOverlayGradient(),
              _buildTextContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  _getOverlayGradient() {
    return ClipRRect(
      borderRadius: new BorderRadius.only(
          bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            colors: [
              const Color(0xFF000000),
              const Color(0x00000000),
            ],
          ),
        ),
      ),
    );
  }

  void openDetail(BuildContext context) {
    Navigator.of(context).push(
      FadeInRoute(
        widget: DetailPage(
          notice: item,
        ),
      ),
    );
  }
}
