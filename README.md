# Log4jPowerShellScanner
A simple powershells script to scan for known affected file hashes in the December 2021 Log4j zero-day flaw.

This script uses the identified hashes documented here:
https://github.com/mubix/CVE-2021-44228-Log4Shell-Hashes/blob/main/sha1sum.txt

This hash list was referenced by LunaSec at the following write-up:
https://www.lunasec.io/docs/blog/log4j-zero-day-mitigation-guide/

The script simply scans everything in the defined $RootSeachPath for the known wildcard of log4j-core versions "log4j-core-*.jar".  Note, this step can take some time if you search your entire root drive.

It then takes the files found to match the wildcard search and calculates their SHA1 hash and comparese it against the known list of affected hashes per the references above.
