cd /etc/initial-data
cat data.zip.* > data.zip && zip -FF data.zip --out data-full.zip && unzip data-full.zip -d /config

