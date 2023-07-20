import 'dart:io'; // dart:io package's Process class


void runProkka(String fastaFilePath, String outputDir, String selectedKingdom) async {
  // Run Prokka with the specified FASTA file, output directory, and kingdom
  // run a process and collect its output
  ProcessResult result = await Process.run(
    'prokka',  // The command to run
    ['--kingdom', selectedKingdom, '--outdir', outputDir, fastaFilePath],  // The arguments to the command
  );

  // Check if the process succeeded
  if (result.exitCode != 0) {
    print('Prokka failed with exit code ${result.exitCode}.');
    print('Standard output:\n${result.stdout}');
    print('Standard error:\n${result.stderr}');
    return;
  }

  // Process succeeded
  print('Prokka succeeded with exit code ${result.exitCode}.');
  print('Standard output:\n${result.stdout}');
}
