import 'package:flutter/material.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EbookPage extends StatefulWidget {
  const EbookPage({super.key});

  @override
  State<EbookPage> createState() => _EbookPageState();
}

class _EbookPageState extends State<EbookPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              width: width * 0.8,
              child: Image.asset('assets/images/SLIDE 7.png'),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getValueForScreenType<double>(
              context: context,
              mobile: 10,
              tablet: 50,
              desktop: 100,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FirestoreService.withoutUID().allEbook,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Map> dataMaps = snapshot.data!;
                    final List<Map> ebook = dataMaps.where((ebookMap) {
                      final dynamic data = ebookMap['ebook'];
                      return data is EbookModel?;
                    }).map((ebookMap) {
                      final EbookModel ebook = ebookMap['ebook'];
                      final String id = ebookMap['id'];
                      return {'ebook': ebook, 'id': id};
                    }).toList();
                    return Column(
                      children: [],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No video learning available.'),
                    );
                  } else {
                    return const Center(
                      child: Text('kok iso.'),
                    );
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
