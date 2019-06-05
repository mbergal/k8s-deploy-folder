$ErrorActionPreference = "Stop"

$configMaps = ls c:\etc\initial-data `
| Select-Object -ExpandProperty Name -Unique


Write-Host "Cleaning directory c:\temp"
If (test-path c:\temp) {
    rm -r -fo c:\temp
}
mkdir c:\temp


Write-Host "...done"
foreach ( $configMap in $configMaps ) {
    Write-Host "Copying $configMap to temp..."
    cp /etc/initial-data/$configMap/$configMap c:/temp
    Write-Host "...done"
}

Write-Host "Unpacking data.zip.* from c:\temp into c:\config"
c:\bin\7z x c:\temp\data.zip.001 -oc:/config/
Write-Host "...done"
