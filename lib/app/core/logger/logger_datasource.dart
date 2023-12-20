abstract class LoggerDatasource {
  call({
    required Map<String, dynamic> data,
  });

  addApiAuthorization({
    String userAuth,
    String passAuth,
    String tenantID,
  });
}
