import 'package:cloud_firestore/cloud_firestore.dart';


class VideoLearning {
  String? image;
  String? title;
  String? description;
  List<String>? benefits;
  List<ListLearningVideo>? listLearningVideo;
  List<ChapterListVideo>? chapterListvideo;
  bool? isDraft;
  String? price;
  String? discount;

  VideoLearning({
    required this.image,
    required this.title,
    required this.price,
    required this.benefits,
    this.description,
    this.discount = "",
    this.isDraft,
    this.chapterListvideo,
    this.listLearningVideo,
  });

  factory VideoLearning.fromFirestore(Map<String, dynamic> data) {
    final List<dynamic>? learningVideoData = data['list_learing'];
    final List<dynamic>? chapterListVideoData = data['chapter_list'];

    final List<ListLearningVideo>? learningLists =
        learningVideoData?.map((learningData) {
      return ListLearningVideo.fromFirestore(learningVideoData as Map<String, dynamic>);
    }).toList();

    final List<ChapterListVideo>? chapterListVideos = chapterListVideoData?.map((chapterListvideo) {
      return ChapterListVideo.fromFirestore(chapterListvideo as Map<String, dynamic>);
    }).toList();

    return VideoLearning(
      image: data['image'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
      chapterListvideo: chapterListVideos,
      benefits: (data['completion_benefits'] as List<dynamic>).cast<String>(),
      isDraft: data['is_draft'],
      discount: data['discount'],
      listLearningVideo: learningLists,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'is_draft': isDraft,
      'price': price,
      'discount': discount,
      'completion_benefits': benefits ?? [],
      'list_learning':
          listLearningVideo?.map((learning) => learning.toFirestore()).toList(),
      'chapter_list_video':
          chapterListvideo?.map((chapter) => chapter.toFirestore()).toList(),
    };
  }
}

class ListLearningVideo {
  String? image;
  String? title;
  String? description;
  String? price;

  ListLearningVideo({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  factory ListLearningVideo.fromFirestore(Map<String, dynamic> data) {
    return ListLearningVideo(
      image: data['image'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'price': price,
    };
  }
}

class ChapterListVideo {
  String? chapter;
  List<String>? subChapter;

  ChapterListVideo({
    required this.chapter,
    List<String>? subChapter,
  }) : subChapter = subChapter ?? [];

  // Convert Firestore data to ChapterList object
  factory ChapterListVideo.fromFirestore(Map<String, dynamic> data) {
    return ChapterListVideo(
      chapter: data['chapter'],
      subChapter: (data['sub_chapter'] as List<dynamic>)
          .cast<String>(), // Ensure it's a List of Strings
    );
  }

  // Convert ChapterListVideo object to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'chapter': chapter,
      'sub_chapter': subChapter ?? [],
    };
  }
}

class LearnVideo {
  String? title;
  String? videoUrl;
  DateTime? createdAt;

  LearnVideo({
    required this.title,
    this.videoUrl,
    this.createdAt,
  });

  factory LearnVideo.fromFirebase(Map<String, dynamic> data) {
    return LearnVideo(
      title: data['title'],
      videoUrl: data['video_url'],
      createdAt: data['created_at'].toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'video_url': videoUrl,
      'created_at': Timestamp.fromDate(createdAt!)
    };
  }
}
