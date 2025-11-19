// upload_analyze_page.dart
import 'dart:async';
import 'package:flutter/material.dart';

class UploadAnalyzePage extends StatefulWidget {
  const UploadAnalyzePage({Key? key}) : super(key: key);

  @override
  State<UploadAnalyzePage> createState() => _UploadAnalyzePageState();
}

class _UploadAnalyzePageState extends State<UploadAnalyzePage> {
  bool isAnalyzing = false;
  bool analysisComplete = false;
  bool isPlaying = false;
  int analysisProgress = 0;
  String currentTime = "00:00:00";
  String? uploadedFileName;
  double uploadedFileSizeMB = 0;

  final List<Map<String, dynamic>> mockAnalysisResults = [
    {'timestamp': '00:01:23', 'event': 'Unauthorized Entry', 'confidence': 95, 'severity': 'high'},
    {'timestamp': '00:02:45', 'event': 'Person Detected', 'confidence': 88, 'severity': 'medium'},
    {'timestamp': '00:04:12', 'event': 'Vehicle Movement', 'confidence': 92, 'severity': 'low'},
    {'timestamp': '00:05:33', 'event': 'Weapon Detected', 'confidence': 87, 'severity': 'critical'},
    {'timestamp': '00:07:18', 'event': 'Face Recognition Match', 'confidence': 96, 'severity': 'info'},
  ];

  void startAnalysis() {
    setState(() {
      isAnalyzing = true;
      analysisProgress = 0;
      analysisComplete = false;
    });

    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        if (analysisProgress >= 100) {
          timer.cancel();
          isAnalyzing = false;
          analysisComplete = true;
          analysisProgress = 100;
        } else {
          analysisProgress += 10;
        }
      });
    });
  }

  Color getSeverityColor(String severity) {
    switch (severity) {
      case 'critical':
        return Colors.red.shade600;
      case 'high':
        return Colors.orange.shade600;
      case 'medium':
        return Colors.yellow.shade600;
      case 'low':
        return Colors.blue.shade600;
      case 'info':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Icon getSeverityIcon(String severity) {
    switch (severity) {
      case 'critical':
      case 'high':
        return const Icon(Icons.warning, size: 16, color: Colors.white);
      case 'info':
        return const Icon(Icons.check_circle, size: 16, color: Colors.white);
      default:
        return const Icon(Icons.access_time, size: 16, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text('Upload & Analyze'),
        backgroundColor: const Color(0xFF2A2A2A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload video files for AI-powered analysis',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Upload Section
            Card(
              color: const Color(0xFF2A2A2A),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'File Upload',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        // Here you would use file picker plugin
                        // Example: file_picker or image_picker
                        setState(() {
                          uploadedFileName = "example_video.mp4";
                          uploadedFileSizeMB = 12.5;
                        });
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF1A1A1A),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.video_file, size: 48, color: Colors.grey),
                              SizedBox(height: 8),
                              Text(
                                'Click to upload video/audio file',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Supports MP4, AVI, MOV, MP3, WAV (Max 500MB)',
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (uploadedFileName != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(uploadedFileName!, style: const TextStyle(color: Colors.white)),
                              Text("${uploadedFileSizeMB.toStringAsFixed(2)} MB",
                                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: isAnalyzing || analysisComplete ? null : startAnalysis,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                            ),
                            child: Text(isAnalyzing ? 'Analyzing...' : 'Start Analysis'),
                          ),
                        ],
                      ),
                    ],
                    if (isAnalyzing) ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Analysis Progress', style: TextStyle(color: Colors.grey)),
                          Text('$analysisProgress%', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: analysisProgress / 100,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade800,
                        color: Colors.blue.shade600,
                      ),
                    ]
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Video Player & Timeline
            if (analysisComplete)
              Card(
                color: const Color(0xFF2A2A2A),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Video Playback & Timeline',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.video_file, size: 48, color: Colors.grey),
                              SizedBox(height: 4),
                              Text('Video Player', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                                onPressed: () => setState(() => isPlaying = !isPlaying),
                              ),
                              Text(currentTime + ' / 00:08:30', style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download, size: 16),
                            label: const Text('Export Report'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Timeline
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.33,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          // Flags
                          Positioned(left: 0.25 * MediaQuery.of(context).size.width, top: 0, child: flag(Colors.red)),
                          Positioned(left: 0.5 * MediaQuery.of(context).size.width, top: 0, child: flag(Colors.yellow)),
                          Positioned(left: 0.75 * MediaQuery.of(context).size.width, top: 0, child: flag(Colors.orange)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Analysis Results
            Card(
              color: const Color(0xFF2A2A2A),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Analysis Results',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    if (!analysisComplete)
                      Column(
                        children: const [
                          Icon(Icons.video_file, size: 48, color: Colors.grey),
                          SizedBox(height: 4),
                          Text('Upload and analyze a file to see results', style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    else
                      Column(
                        children: mockAnalysisResults.map((result) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: getSeverityColor(result['severity']),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(result['severity'].toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10)),
                                    ),
                                    Text(result['timestamp'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    getSeverityIcon(result['severity']),
                                    const SizedBox(width: 4),
                                    Text(result['event'], style: const TextStyle(color: Colors.white, fontSize: 14)),
                                  ],
                                ),
                                Text('Confidence: ${result['confidence']}%', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget flag(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
