import 'package:flutter/material.dart';
import 'package:booker/model/apartment_model.dart';
import 'package:booker/model/profile_responce_model.dart';

class SelectDateScreen extends StatefulWidget {
  final ApartmentModel model;
  final ProfileResponceModel profile;

  const SelectDateScreen({
    super.key,
    required this.model,
    required this.profile,
  });

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Rent Dates")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: const Text("Start Date"),
              subtitle: Text(
                startDate != null
                    ? "${startDate!.day}/${startDate!.month}/${startDate!.year}"
                    : "Choose start date",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => startDate = picked);
              },
            ),

            const SizedBox(height: 12),

            ListTile(
              title: const Text("End Date"),
              subtitle: Text(
                endDate != null
                    ? "${endDate!.day}/${endDate!.month}/${endDate!.year}"
                    : "Choose end date",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: startDate ?? DateTime.now(),
                  firstDate: startDate ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => endDate = picked);
              },
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                if (startDate != null && endDate != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentMethodScreen(
                        model: widget.model,
                        profile: widget.profile,
                        startDate: startDate!,
                        endDate: endDate!,
                      ),
                    ),
                  );
                }
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodScreen extends StatelessWidget {
  final ApartmentModel model;
  final ProfileResponceModel profile;
  final DateTime startDate;
  final DateTime endDate;

  const PaymentMethodScreen({
    super.key,
    required this.model,
    required this.profile,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Payment Method")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewSummaryScreen(
                      model: model,
                      profile: profile,
                      startDate: startDate,
                      endDate: endDate,
                      paymentMethod: "Debit Card",
                    ),
                  ),
                );
              },
              child: const Text("Pay with Debit Card"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewSummaryScreen(
                      model: model,
                      profile: profile,
                      startDate: startDate,
                      endDate: endDate,
                      paymentMethod: "USSD",
                    ),
                  ),
                );
              },
              child: const Text("Pay with USSD"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewSummaryScreen(
                      model: model,
                      profile: profile,
                      startDate: startDate,
                      endDate: endDate,
                      paymentMethod: "Bank Transfer",
                    ),
                  ),
                );
              },
              child: const Text("Pay with Bank Transfer"),
            ),
          ],
        ),
      ),
    );
  }
}


class ReviewSummaryScreen extends StatelessWidget {
  final ApartmentModel model;
  final ProfileResponceModel profile;
  final DateTime startDate;
  final DateTime endDate;
  final String paymentMethod;

  const ReviewSummaryScreen({
    super.key,
    required this.model,
    required this.profile,
    required this.startDate,
    required this.endDate,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Review Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Apartment: ${model.city}, ${model.governorate}"),
            Text("Price: ${model.rentPrice} SYP / month"),
            Text("Start Date: ${startDate.day}/${startDate.month}/${startDate.year}"),
            Text("End Date: ${endDate.day}/${endDate.month}/${endDate.year}"),

            const Divider(),

            Text("Name: ${profile.firstName} ${profile.lastName}"),
            Text("Date of Birth: ${profile.dateOfBirth}"),
            Text("User ID: ${profile.userId}"),

            const Divider(),

            Text("Payment Method: $paymentMethod"),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // لاحقاً: إرسال طلب الحجز للـ API
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Booking Confirmed!")),
                );
              },
              child: const Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}