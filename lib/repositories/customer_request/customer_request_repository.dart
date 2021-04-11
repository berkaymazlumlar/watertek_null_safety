import 'package:teknoloji_kimya_servis/api/get_apis.dart';
import 'package:teknoloji_kimya_servis/models/api_request.dart';

class CustomerRequestRepository {
  ApiCustomerRequest _apiCustomerRequest;

  ApiCustomerRequest get apiCustomerRequest => _apiCustomerRequest;

  set apiCustomerRequest(ApiCustomerRequest apiCustomerRequest) {
    _apiCustomerRequest = apiCustomerRequest;
  }

  Future<ApiCustomerRequest> getCustomerRequest({int customerId}) async {
    final _response = await GetApi.getCustomerRequest(customerId: customerId);
    print("CUSTOMER REQUEST RESPONSE : ${_response.toJson()}");
    if (_response != null) {
      _apiCustomerRequest = _response;
      return _response;
    } else {
      return null;
    }
  }
}
