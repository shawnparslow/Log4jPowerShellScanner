# Log4jPowerShellScanner
A simple powershells script to scan for known file versions containing the impacted class in the December 2021 Log4j zero-day flaw.

This script uses the identified version documented here:
https://github.com/mubix/CVE-2021-44228-Log4Shell-Hashes/blob/main/sha1sum.txt

This hash list was referenced by LunaSec at the following write-up:
https://www.lunasec.io/docs/blog/log4j-zero-day-mitigation-guide/

The script simply scans everything in the defined $RootSeachPath for the known wildcard of log4j-core versions "log4j-core-*.jar".  Note, this step can take some time if you search your entire root drive.

It then takes the files found to match the wildcard search and checks the versions against the known list, if the version matches the .jar is expanded and the script checks for the impacted class to be in the jar files contents.

One manual option for a quick remediation of .jar files that have the issue is to unarchive them, remove the class (jndilookup.class), and re-archive them and patch.  The may break applications that are using Log4J however so its really only viable if your applicaiton is not using the mentioned class.

This script does not make any attempts to patch, it only reports findings.
