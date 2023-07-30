class CommonResponse<T> {
  // we are going to handle many kinds of response models (user model - order model...) => we used generic programming
  T? data; // the difference between models is the data then it's type will be changed according to <T> the model of response
  int? statusCode;
  String? message;

  CommonResponse.fromJson(Map<String, dynamic> json) {
    // to make a model from a json object (parsing) - to avoide errors if the api replied with nothing we are going to surround our function body with try -catch
    try {
      // to avoide application crash if any problem happend we will handle it as an exception
      this.statusCode = json['statusCode'];
      if (statusCode == 200) {
        this.data = json['response'];
      } else {
        if (json['response'] !=
                null && // to avoide excution errors from the api - condition 1 :there is a key that is named 'response'
            json['response']
                is Map && // condition 2 :it has a value => is it a formated json?
            json['response']['title'] != null) {
          // condition 3 :there is a key that is named 'Title' and has value
          this.message = json['response']
              ['title']; // the error message from the response of the api
        } else {
          switch (statusCode) {
            case 400:
              message = '400 Bad request';
              break;
            case 401:
              message = '401 Unauthorized';
              break;
            case 500:
              message = '500 Internal server error';
              break;
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool get getStatus => statusCode == 200
      ? true
      : false; // to avoide retyping the condition that tests the statusCode every where, we initialized the getter
  //now any where i have to test statusCode i can use CommonResponse.getStatus();
}
