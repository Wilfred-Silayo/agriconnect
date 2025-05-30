import 'dart:async';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralServices {
  final supabase = Supabase.instance.client;
  final DateTime sentTime = DateTime.now();

  /// Function to post a crop
  Future<void> postCrop({
    required String bei,
    required String kipimo,
    required String mkulima,
    required String stock,
    required String imageUrl,
    required String mazao,
    required String simu,
  }) async {
    try {
      await supabase.from('Posts').insert({
        'Bei': bei,
        'Kipimo': kipimo,
        'Mkulima': mkulima,
        'Stock': stock,
        'image': imageUrl,
        'Mazao': mazao,
        'Simu': simu,
      });
      print('Crop posted successfully');
    } catch (e) {
      print('Error posting crop: $e');
    }
  }

  /// Function when the Order is Created
  Future<void> orderPressed({
    required String offered,
    required String kiasi,
    required String seller,
    required String buyer,
    required String sellerPhone,
  }) async {
    try {
      await supabase.from('OrderPres').insert({
        'ofa': offered,
        'Kiasi': kiasi,
        'Farmer': seller,
        'Buyer': buyer,
        'SellerPhone': sellerPhone,
        'Status': 'Pending',
      });
      print('Order created successfully');
    } catch (e) {
      print('Error creating order: $e');
    }
  }

  /// Function to update Order Status to 'Accepted'
  Future<void> updateOrder(String orderId) async {
    try {
      await supabase
          .from('OrderPres')
          .update({'Status': 'Accepted'})
          .eq('id', orderId);
      print('Order updated successfully');
    } catch (e) {
      print('Error updating order: $e');
    }
  }

  /// Function to reject Order
  Future<void> rejectOrder(String orderId) async {
    try {
      await supabase
          .from('OrderPres')
          .update({'Status': 'Imekataliwa'})
          .eq('id', orderId);
      print('Order rejected successfully');
    } catch (e) {
      print('Error rejecting order: $e');
    }
  }

  /// Function to update Stock
  Future<void> updateStock(String sellerId, String newQuantity) async {
    try {
      await supabase
          .from('Posts')
          .update({'Stock': newQuantity})
          .eq('Mkulima', sellerId);
      print('Stock updated successfully');
    } catch (e) {
      print('Error updating stock: $e');
    }
  }

  /// Function to delete the Order
  Future<void> deleteOrder(String orderId) async {
    try {
      await supabase.from('OrderPres').delete().eq('id', orderId);
      print('Order deleted successfully');
    } catch (e) {
      print('Error deleting order: $e');
    }
  }

  /// Function to get Post Details and update stock
  Future<void> getPostDetails(String sellerId, String orderQuantity) async {
    try {
      final response = await supabase
          .from('Posts')
          .select('Stock')
          .eq('Mkulima', sellerId)
          .single();

      final stock = double.tryParse(response['Stock'].toString()) ?? 0.0;
      final quant = double.tryParse(orderQuantity) ?? 0.0;
      final newStock = (stock - quant).toString();

      await updateStock(sellerId, newStock);
    } catch (e) {
      print('Error retrieving post details or updating stock: $e');
    }
  }

  /// Function to make a phone call
  Future<void> makingPhoneCall(String phoneNumber) async {
    final url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Function to receive Order
  Future<void> receivedOrder(String orderValue) async {
    try {
      await supabase.from('RecievedOrders').insert({
        'SoldStock': orderValue,
      });
      print('Received order recorded successfully');
    } catch (e) {
      print('Error recording received order: $e');
    }
  }

  /// Function to send SMS
  Future<void> sendSMS({
    required String body,
    required String buyer,
    required String farmer,
    required String sender,
  }) async {
    try {
      await supabase.from('Messages').insert({
        'Buyer': buyer,
        'Farmer': farmer,
        'body': body,
        'Date': 'Test Date',
        'Sender': sender,
        'SentTime': sentTime.toIso8601String(),
      });
      print('SMS sent successfully');
    } catch (e) {
      print('Error sending SMS: $e');
    }
  }

  /// Function to post in forum
  Future<void> jamiiPost({
    required String body,
    required String poster,
  }) async {
    final docId = '$poster ${sentTime.toIso8601String()}';
    try {
      await supabase.from('JamiiPosts').insert({
        'id': docId,
        'Poster': poster,
        'body': body,
        'SentTime': sentTime.toIso8601String(),
      });
      print('Posted to forum successfully');
    } catch (e) {
      print('Error posting to forum: $e');
    }
  }

  /// Function to comment on a post
  Future<void> commentPost({
    required String body,
    required String contributor,
  }) async {
    final docId = '$contributor ${sentTime.toIso8601String()}';
    try {
      await supabase.from('JamiiPosts').insert({
        'id': docId,
        'Contributer': contributor,
        'body': body,
        'SentTime': sentTime.toIso8601String(),
      });
      print('Comment posted successfully');
    } catch (e) {
      print('Error commenting on post: $e');
    }
  }

  /// Function to upload image to Supabase Storage
  Future<String?> uploadImageToSupabase(File imageFile) async {
    try {
      final fileName = basename(imageFile.path);
      final filePath = 'public/$fileName';

      await supabase.storage.from('avatars').upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final publicUrl =
          supabase.storage.from('avatars').getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
