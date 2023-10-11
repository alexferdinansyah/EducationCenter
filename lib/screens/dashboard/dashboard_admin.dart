import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/articles.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:project_tc/services/firestore_service.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: StreamBuilder(
        stream: FirestoreService.withoutUID().getCombinedStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final List<Map> dataMaps = snapshot.data!;

            final List<Map> bundleCourses = dataMaps
                .where((courseMap) {
                  final dynamic data = courseMap['course'];
                  return data is Course && data.isBundle == true;
                })
                .map((courseMap) {
                  final Course course = courseMap['course'];
                  final String id = courseMap['id'];
                  return {'course': course, 'id': id};
                })
                .take(3)
                .toList();

            final List<Map> nonBundleCourses = dataMaps
                .where((courseMap) {
                  final dynamic data = courseMap['course'];
                  return data is Course && data.isBundle == false;
                })
                .map((courseMap) {
                  final Course course = courseMap['course'];
                  final String id = courseMap['id'];
                  return {'course': course, 'id': id};
                })
                .take(6)
                .toList();

            final List<Map> articles = dataMaps.where((articleData) {
              final dynamic data = articleData['article'];
              return data is Article;
            }).map((articleData) {
              final Article article = articleData['article'];
              final String id = articleData['id'];
              return {'article': article, 'id': id};
            }).toList();

            return ListView(
              children: [
                SizedBox(
                  height: height / 1.9,
                  width: width / 1.7,
                  child: LiveGrid(
                      itemCount: bundleCourses.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: height * .51,
                        crossAxisCount: 3, // Number of items per row
                        crossAxisSpacing: width *
                            .02, // Adjust spacing between items horizontally
                        mainAxisSpacing:
                            16.0, // Adjust spacing between rows vertically
                      ),
                      itemBuilder: animationBuilder((index) => Courses(
                            course: bundleCourses[index]['course'],
                            id: bundleCourses[index]['id'],
                          ))),
                ),
                SizedBox(
                  height: height / 1.9,
                  width: width / 1.7,
                  child: LiveGrid(
                      itemCount: nonBundleCourses.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: height * .51,
                        crossAxisCount: 3, // Number of items per row
                        crossAxisSpacing: width *
                            .02, // Adjust spacing between items horizontally
                        mainAxisSpacing:
                            16.0, // Adjust spacing between rows vertically
                      ),
                      itemBuilder: animationBuilder((index) => Courses(
                            course: nonBundleCourses[index]['course'],
                            id: nonBundleCourses[index]['id'],
                          ))),
                ),
                SizedBox(
                  height: height / 1.9,
                  width: width / 1.7,
                  child: LiveGrid(
                      itemCount: articles.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: height * .51,
                        crossAxisCount: 3, // Number of items per row
                        crossAxisSpacing: width *
                            .02, // Adjust spacing between items horizontally
                        mainAxisSpacing:
                            16.0, // Adjust spacing between rows vertically
                      ),
                      itemBuilder: animationBuilder((index) => Articles(
                            article: articles[index]['article'],
                            id: articles[index]['id'],
                          ))),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final firestoreService = FirestoreService.withoutUID();

                      final newCourse = Course(
                          image: 'assets/images/web_dev.jpeg',
                          courseCategory: 'Online course',
                          title: 'Junior web developer',
                          description:
                              'Prepare your skills to become a Web Developer by following this course bundle. You will learn through case studies and projects that you can put into practice.',
                          isBundle: true,
                          price: '400.000',
                          totalCourse: '5 Courses',
                          listCourse: [
                            ListCourse(
                              image: '',
                              title: 'Basic HTML',
                              description: 'Hyper Text Markup Language',
                              price: '100.000',
                            ),
                            ListCourse(
                              image: '',
                              title: 'Basic CSS',
                              description: 'For styling website',
                              price: '100.000',
                            ),
                            ListCourse(
                              image: '',
                              title: 'Basic Javascript',
                              description:
                                  'To make the website more lively, dynamic, and interactive',
                              price: '100.000',
                            ),
                            ListCourse(
                              image: '',
                              title: 'Basic PHP',
                              description:
                                  'PHP is a general-purpose scripting language widely used as a server-side language',
                              price: '100.000',
                            ),
                            ListCourse(
                              image: '',
                              title: 'Basic MySql',
                              description:
                                  'MySQL is a widely used relational database management system (RDBMS).',
                              price: '100.000',
                            ),
                          ],
                          completionBenefits: [
                            'Be able to understand HTML, CSS and Javascript languages',
                            'Be able to create a web with a responsive appearance',
                            'Understanding PHP Syntax',
                            'Understanding Basic of Database',
                            'Can Design Database Systems',
                          ],
                          courseType: 'Premium',
                          discount: '10');

                      await firestoreService.addCourse(newCourse);
                    },
                    child: const Text('ADD COURSE')),
                ElevatedButton(
                    onPressed: () async {
                      final firestoreService = FirestoreService.withoutUID();

                      final newArticle = Article(
                          image: 'assets/images/micomet.jpg',
                          category: 'UI/UX',
                          title: 'Tips to learn Figma from Profesional',
                          description:
                              "Figma has rapidly emerged as one of the premier design and prototyping tools in the digital industry. Its collaborative features, versatility, and user-friendly interface have made it a favorite among professionals across the globe. If you're looking to harness the power of Figma and learn from the best, these expert tips will guide you on your journey to becoming a Figma pro.",
                          date: '20 August 2023',
                          articleContent: [
                            ArticleContent(
                                subTitle: '1. Start with the Basics:',
                                subTitleDescription:
                                    "No matter how experienced you are in design or other tools, it's always a good idea to start with the basics. Familiarize yourself with Figma's user interface, tools, and shortcuts. Understanding the layout and core functionalities will set a strong foundation for your learning journey."),
                            ArticleContent(
                                subTitle:
                                    '2. Leverage Official Documentation and Tutorials:',
                                subTitleDescription:
                                    'Figma offers comprehensive official documentation and tutorials. These resources are designed to help users of all levels understand and master the tool. From understanding layers and components to working with plugins, the official guides provide step-by-step instructions and explanations.'),
                            ArticleContent(
                                subTitle: 'Learn Keyboard Shortcuts:',
                                image: '',
                                subTitleDescription:
                                    'Efficiency is key in the fast-paced world of design. Learning keyboard shortcuts can significantly speed up your workflow. Memorize shortcuts for frequently used tools and actions, such as creating shapes, grouping elements, and zooming in and out'),
                            ArticleContent(
                                subTitle: 'Conclusion',
                                subTitleDescription:
                                    "In conclusion, learning Figma from professionals involves a combination of mastering the tool's features and understanding the broader principles of design. By starting with the basics, leveraging official resources, and embracing collaboration and feedback, you can rapidly progress from a novice to a proficient Figma user. Remember that patience and persistence are key, and as you refine your skills, you'll find yourself creating stunning designs with ease and confidence.")
                          ]);

                      await firestoreService.addArticle(newArticle);
                    },
                    child: const Text(' ADD ARTICLE')),
                ElevatedButton(
                    onPressed: () async {
                      final AuthService auth = AuthService();
                      auth.signOut();
                    },
                    child: const Text('LOGUT'))
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No courses available.'),
            );
          } else {
            return const Center(
              child: Text('kok iso.'),
            );
          }
        },
      ),
    );
  }
}
