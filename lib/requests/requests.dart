import "dart:convert";
import 'dart:html' as html;
import "package:flutter_dotenv/flutter_dotenv.dart" as dotenv;
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart' show Logger;
import "package:remotefilesystem/login/loginlogic.dart";

final String serverIP = dotenv.dotenv.env['SERVER_IP'] ?? 'localhost';
final logger = Logger();

Future<dynamic> postCreateDir(name) async {
  final token = getToken();
  //'Access-Control-Allow-Origin': '*',

  final url = Uri.https(serverIP, '/api/v1/directories/create', {
    'name': '$name',
  });
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Origin': 'https://$serverIP',
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Origin, Content-Type, Accept, Authorization',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      logger.i(jsonResponse);
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('Error: $e');
  }
}

Future<List<dynamic>> getDirList() async {
  final token = getToken();
  final url = Uri.https(serverIP, '/api/v1/directories/list');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST',
    'Access-Control-Allow-Headers':
        'Origin, Content-Type, Accept, Authorization',
  };

  try {
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse.map((dir) => dir as Map<String, dynamic>).toList();
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('Error: $e');
    return ['Error: $e'];
  }
  return [];
}

Future<dynamic> postRegisterRequest(Map<String, dynamic> data) async {
  try {
    final response = await http.post(
      Uri.parse("$serverIP/api/v1/auth/register"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Origin': 'https://$serverIP',
        'X-Requested-With': 'XMLHttpRequest',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
        'Access-Control-Allow-Headers':
            'Content-Type, Accept, X-Requested-With',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    logger.e('Failed to send json: $error');
    return 'Failed to send json: $error';
  }
}

Future<dynamic> postLoginRequest(Map<String, dynamic> data) async {
  try {
    final response = await http.post(
      Uri.parse("https://$serverIP/api/v1/auth/authenticate"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Origin': 'https://$serverIP',
        'X-Requested-With': 'XMLHttpRequest',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
        'Access-Control-Allow-Headers':
            'Content-Type, Accept, X-Requested-With',
      },
    );

    if (response.statusCode == 200) {
      logger.i("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
  } catch (error) {
    logger.e('Failed to send json: $error');
    return 'Failed to send json: $error';
  }
}

Future<bool> postUploadFile(html.File file, int directoryId) async {
  final token = getToken();
  final url = Uri.parse('https://nas.nimbuspicloud.org/api/v1/files/upload');
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json, */*',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Content-Type, Accept, Authorization, X-Requested-With',
  };

  try {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['directoryId'] = directoryId.toString()
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        reader.result as List<int>,
        filename: file.name,
      ));

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(responseBody);
        logger.i(jsonResponse);
        return true;
      } catch (e) {
        // Handle plain text response
        logger.i(responseBody);
        return responseBody.contains('File uploaded successfully');
      }
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    logger.e('Error: $e');
    return false;
  }
}

Future<bool> postDeleteDir(int directoryId) async {
  final token = getToken();
  final url = Uri.parse(
      'https://nas.nimbuspicloud.org/api/v1/directories/delete?dirId=$directoryId');
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Content-Type, Accept, Authorization, X-Requested-With',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      logger.i('Directory deleted successfully');
      return true;
    } else if (response.statusCode == 500) {
      final errorMessage = response.body;
      logger.e('Server error: $errorMessage');
      return false;
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    logger.e('Network error: $e');
    return false;
  }
}

Future<bool> postEditDirName(int directoryId, String newName) async {
  final token = getToken();
  final url =
      Uri.https('nas.nimbuspicloud.org', '/api/v1/directories/editName', {
    'dirId': directoryId.toString(),
    'newName': newName,
  });
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Content-Type, Accept, Authorization, X-Requested-With',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        logger.i(jsonResponse);
        return true;
      } catch (e) {
        // Handle plain text response
        logger.i(response.body);
        return response.body.contains('File name edited successfully');
      }
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    logger.e('Error: $e');
    return false;
  }
}

Future<bool> postCreateDirInDir(String subDirName, String parentDirPath) async {
  final token = getToken();
  final url = Uri.parse(
      'https://nas.nimbuspicloud.org/api/v1/directories/createDirInDir?name=$subDirName&parentDirPath=$parentDirPath');
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Content-Type, Accept, Authorization, X-Requested-With',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      logger.i(jsonResponse);
      return true;
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    logger.e('Error: $e');
    return false;
  }
}

Future<bool> postDownloadFile(String fileName, String filePath) async {
  final token = getToken();
  final path = '$filePath\\$fileName';
  logger.i('Downloading file: $path');

  final url = Uri.parse('https://nas.nimbuspicloud.org/api/v1/files/download');
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Content-Type, Accept, Authorization, X-Requested-With',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"filename": fileName, "filepath": path}),
    );

    if (response.statusCode == 200) {
      try {
        // Create blob and trigger download
        final blob = html.Blob([response.bodyBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", fileName)
          ..style.display = 'none';

        html.document.body?.children.add(anchor);
        anchor.click();

        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);

        logger.i('File downloaded successfully: $fileName');
        return true;
      } catch (e) {
        logger.e('Error creating download: $e');
        return false;
      }
    } else {
      logger.e('Download failed with status: ${response.statusCode}');
      logger.e('Response: ${response.body}');
      return false;
    }
  } catch (e) {
    logger.e('Download error: $e');
    return false;
  }
}

Future<bool> postDeleteFile(String fileName, String filePath) async {
  final token = getToken();
  final url = Uri.parse(
      'https://nas.nimbuspicloud.org/api/v1/files/delete?filename=$fileName&filepath=$filePath');
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Content-Type, Accept, Authorization, X-Requested-With',
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      logger.i(response.body);
      return response.body.contains('File deleted successfully');
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    logger.e('Error: $e');
    return false;
  }
}

Future<List<dynamic>> getFileList() async {
  final token = getToken();
  final url = Uri.https('nas.nimbuspicloud.org', '/api/v1/files/list');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Origin': 'https://$serverIP',
    'X-Requested-With': 'XMLHttpRequest',
    'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
    'Access-Control-Allow-Headers':
        'Content-Type, Accept, Authorization, X-Requested-With',
  };

  try {
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse.map((file) => file as Map<String, dynamic>).toList();
    } else {
      logger.e('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('Error: $e');
    return ['Error: $e'];
  }
  return [];
}
