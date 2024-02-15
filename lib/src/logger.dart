import 'package:logging/logging.dart';

Logger _logger = Logger('nayef_common_domain_toolkit_logger');

Logger get logger => _logger;

void setLoggerName(String loggerName) {
  _logger = Logger(loggerName);
}
