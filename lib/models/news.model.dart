class NewsModel {
  String? url = '';

  UserModel(String url) {
    this.url = url;
  }

  imageFromJsonToObject(String image) {
    this.url = image;
  }

  studentFromObjectToJson() {
    return {
      'url': this.url,
    };
  }
}
