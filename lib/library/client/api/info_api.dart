import 'package:carrefour/library/library.dart';

class InfoApi extends IOClient {
  Future<IOResponse> getBranches() {
    const path = '/api/site/branch/list';
    return sendGetRequest(path);
  }

  Future<IOResponse> getContact() {
    const path = '/api/site/contact';
    return sendGetRequest(path);
  }

  Future<IOResponse> getFaq() {
    const path = '/api/site/faq';
    return sendGetRequest(path);
  }

  Future<IOResponse> getTerms() {
    const path = '/api/site/conditions';
    return sendGetRequest(path);
  }

  Future<IOResponse> getPolicy() {
    const path = '/api/site/privacy';
    return sendGetRequest(path);
  }
}
