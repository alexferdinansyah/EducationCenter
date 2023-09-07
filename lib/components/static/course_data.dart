import 'package:project_tc/models/course.dart';

List<Course> courses = [
  Course(
      image: 'assets/images/web_dev.jpeg',
      typeCourse: 'Online course',
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
      discount: '10'),
  Course(
      image: '',
      typeCourse: 'Online course',
      title: 'Junior web developer',
      isBundle: true,
      price: '400.000',
      totalCourse: '5 Courses',
      discount: '10'),
  Course(
      image: '',
      typeCourse: 'Online course',
      title: 'Junior web developer',
      isBundle: true,
      price: '400.000',
      totalCourse: '5 Courses',
      discount: '10'),
  Course(
    image: 'assets/images/vbNet.jpeg',
    typeCourse: 'Online course',
    title: 'Introduction to VB.NET',
    isBundle: false,
    price: '100.000',
    discount: '10',
    completionBenefits: [
      'Be able to understand HTML',
      'Be able to create a web',
      'Understanding HTML request',
      'Understanding HTML elements',
      'Understanding HTML attributes',
    ],
  ),
  Course(
    image: '',
    typeCourse: 'Online course',
    title: 'Learn Basic CSS',
    isBundle: false,
    price: '100.000',
  ),
  Course(
    image: '',
    typeCourse: 'Online course',
    title: 'Learn Basic Javascript',
    isBundle: false,
    price: '100.000',
  ),
  Course(
    image: '',
    typeCourse: 'Online course',
    title: 'Learn Basic PHP',
    isBundle: false,
    price: '100.000',
  ),
  Course(
    image: '',
    typeCourse: 'Online course',
    title: 'Learn Basic MySql',
    isBundle: false,
    price: '100.000',
  ),
  Course(
    image: '',
    typeCourse: 'Online course',
    title: 'Learn Basic Flutter',
    isBundle: false,
    price: '100.000',
  ),
];
