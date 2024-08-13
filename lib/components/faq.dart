import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:project_tc/models/faq.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pertanyaan Yang Sering Ditanyakan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ],
        ),

        // Use StreamBuilder to dynamically load Accordion sections
        StreamBuilder(
          stream: FirestoreService.withoutUID().allFaqs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('An error occurred while loading data.'));
            } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return const Center(child: Text('No data available.'));
            }

            final List<Map<String, dynamic>> dataMaps =
                List<Map<String, dynamic>>.from(snapshot.data as List);
            final dataFaq = dataMaps.map((data) {
              final fek = data["faq"] as Faq;
              return AccordionSection(
                header: Text(fek.question as String),
                content: Align(alignment: Alignment.centerLeft, child: Text(fek.answer as String)),
              );
            }).toList();

            return Accordion(
              contentBackgroundColor: Colors.white,
              headerBackgroundColor: Colors.white,
              contentBorderColor: Colors.grey,
              headerBorderColor: Colors.grey,
              headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: dataFaq,
            );
          },
        ),
      ],
    );
  }
}
