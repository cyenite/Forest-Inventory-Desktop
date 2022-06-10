import 'package:flutter/material.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({required Key? key}) : super(key: key);

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.03,
            child: const Center(
                child: Text(
              'Coming Soon',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )),
          ),
          const Divider(),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
            ),
            child: const Center(
              child: Text(
                'Section Two',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(Icons.map),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Subtitle',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                  )
                ],
              ),
              Column(
                children: const [
                  Text(
                    'johndoe@gmail.com',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
