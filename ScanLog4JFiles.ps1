# Root path to search, if you search from the drive root it could take a while
$RootSeachPath = "C:\"

# Log4j Core versions known to be impacted
$KnownImpactedVersions = @(
    'log4j-core-2.0-alpha2.jar'
    'log4j-core-2.0-beta1.jar'
    'log4j-core-2.0-beta2.jar'
    'log4j-core-2.0-beta3.jar'
    'log4j-core-2.0-beta4.jar'
    'log4j-core-2.0-beta5.jar'
    'log4j-core-2.0-beta6.jar'
    'log4j-core-2.0-beta7.jar'
    'log4j-core-2.0-beta8.jar'
    'log4j-core-2.0-beta9.jar'
    'log4j-core-2.0.jar'
    'log4j-core-2.0-rc1.jar'
    'log4j-core-2.0-rc2.jar'
    'log4j-core-2.0.1.jar'
    'log4j-core-2.0.2.jar'
    'log4j-core-2.1.jar'
    'log4j-core-2.2.jar'
    'log4j-core-2.3.jar'
    'log4j-core-2.4.jar'
    'log4j-core-2.4.1.jar'
    'log4j-core-2.5.jar'
    'log4j-core-2.6.jar'
    'log4j-core-2.6.1.jar'
    'log4j-core-2.6.2.jar'
    'log4j-core-2.7.jar'
    'log4j-core-2.8.jar'
    'log4j-core-2.8.1.jar'
    'log4j-core-2.8.2.jar'
    'log4j-core-2.9.0.jar'
    'log4j-core-2.9.1.jar'
    'log4j-core-2.10.0.jar'
    'log4j-core-2.11.0.jar'
    'log4j-core-2.11.1.jar'
    'log4j-core-2.11.2.jar'
    'log4j-core-2.12.0.jar'
    'log4j-core-2.12.1.jar'
    'log4j-core-2.13.0.jar'
    'log4j-core-2.13.1.jar'
    'log4j-core-2.13.2.jar'
    'log4j-core-2.13.3.jar'
    'log4j-core-2.14.0.jar'
    'log4j-core-2.14.1.jar'
    'log4j-core-2.0-alpha1.jar'
)

# Impacted Class name within Log4j Core
$KnownImpactedClass = "jndilookup.class"

# Search the root location for all log4j Core version files
Write-Host "Scanning Files within $($RootSeachPath) for exploits in log4j-core-*.jar:"
$FilesToInspect = Get-ChildItem -Path $RootSeachPath -Include log4j-core-*.jar -File -Recurse

# Loop through any Log4j Core jar files found in the search
ForEach ($file in $FilesToInspect) {

    # Filter to only look at file versions by known impacted versions
    If ( $KnownImpactedVersions.Contains($file.name) ){
        Write-Host "A potentially exploited version was detected at $($file.FullName)" -ForegroundColor yellow

        # If the version potentially contains the exploit it is expanded to look for the impacted class
        $TempExpandPath = "$($env:TEMP)\$($file.name)\"
        Write-Host "...Expanding\Inspecting contents at $($TempExpandPath)"
        Expand-Archive -Path $file.FullName -DestinationPath $TempExpandPath -Force

        # Look through the expanded jar file contents for the impacted class
        $ClassResults = Get-ChildItem -Path $TempExpandPath -Include $KnownImpactedClass -File -Recurse
        If ( $ClassResults.Count -gt 0 ) {
            Write-Host "$($file.name) at $($file.FullName) contains the exploited class $KnownImpactedClass" -ForegroundColor red
        }
        
        # Clean Up the expanded archive folder
        Remove-Item -LiteralPath $TempExpandPath -Force -Recurse
    }
}
