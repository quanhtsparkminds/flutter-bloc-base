extension ImageTypeEx on String {
  ImageType get imageType {
    if (startsWith('https') || startsWith('http')) {
      return ImageType.network;
    } else if (startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
