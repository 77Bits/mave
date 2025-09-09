import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mave/modules/modules.dart' show Comic;
import 'package:mave/pages/widgets.dart' show ComicCover;
import 'package:mave/pages/widgets/network_issue.dart';



void pushComicPage(BuildContext context, Comic cm){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ComicPage(cm))
  );
}



class ComicPage extends StatelessWidget {
  final Comic comic;

  const ComicPage(this.comic, {super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(comic.title)),
      body  : FutureBuilder(
        future : Future.delayed(Duration(seconds: 6)), 
        builder: _snapshotBuilder,
      ),
    );
  }


  Widget _snapshotBuilder(BuildContext context, AsyncSnapshot<void> snapshot){
    List<Widget> children = [_InfoHeader(comic.cover, comic.title)];
    if (snapshot.connectionState != ConnectionState.done)
      children.add(_InfoSection(CircularProgressIndicator()));
  
    else{
      if (snapshot.hasError)
        children.add(_handleError(snapshot.error!));
    }
      
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
    );
  }

  static Widget _handleError(Object error){
    if (error is SocketException)
      return _InfoSection(NetworkIssueRetryWidget((){}));
    return _InfoSection(Text(error.toString()));
  }
}


class _InfoHeader extends StatelessWidget {

  final String imageUrl;
  final String title;
  


  const _InfoHeader(this.imageUrl, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return _InfoSection(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex : 1,
            child: ComicCover(
              imageUrl: imageUrl,
              height: null, 
            ),
          ),
          SizedBox(width: 13),
          Flexible(
            flex: 2,
            child: Text(title),
          )
        ],
      )
    );
  }
}


class _InfoSection extends StatelessWidget {
  final Widget child;

  const _InfoSection(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13),
      child  : ColoredBox(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(13),
          child  : Center(
            child: child,
          ),
        ),
      ),
    );
  }
}





