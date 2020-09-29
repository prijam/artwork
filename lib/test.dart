//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: NestedScrollView(
//        controller: _scrollController,
//        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//          return <Widget>[
//            SliverOverlapAbsorber(
//              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//              sliver: SliverSafeArea(
//                top: false,
//                sliver: SliverAppBar(
//                    leading: InkWell(
//                      onTap: () {
//                        Navigator.of(context).pop();
//                      },
//                      child: Padding(
//                        padding:
//                            EdgeInsets.only(left: width * 3, top: height * 1),
//                        child: Icon(Icons.arrow_back),
//                      ),
//                    ),
//                    iconTheme:
//                        IconThemeData(color: Color.fromRGBO(12, 72, 124, 1.0)),
//                    backgroundColor: Colors.white,
//                    title: Padding(
//                      padding:
//                          EdgeInsets.only(right: width * 2.2, top: height * 1),
//                      child: Text(
//                        widget.name,
//                        style: TextStyle(
//                            color: _theme,
//                            letterSpacing: 0.3,
//                            fontWeight: FontWeight.w800,
//                            fontSize: height * 2.5),
//                      ),
//                    ),
//                    elevation: 2.0,
//                    forceElevated: innerBoxIsScrolled,
//                    expandedHeight: height * 27,
//                    floating: false,
//                    pinned: true,
//                    flexibleSpace: FlexibleSpaceBar(
//                        centerTitle: true, background: backGround())),
//              ),
//            ),
//          ];
//        },
// ,
//      ),
//    );
//  }