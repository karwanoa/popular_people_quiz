import 'package:gallery_saver/gallery_saver.dart';

import '../models/global_variables.dart';

Future<bool> saveNetworkImage(String imagePath) async {
  String path = imageUrlBase + imagePath;
  return GallerySaver.saveImage(path).then((value) {
    return value!;
  });
}
