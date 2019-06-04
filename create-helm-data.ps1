$ErrorActionPreference = "Stop"

bin\7z.exe a -v500k -mx=9 -r helm-data/data.zip ./data/*
