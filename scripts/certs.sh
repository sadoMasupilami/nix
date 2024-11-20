#!/bin/bash
# this is needed if firewall inspection is used and the tls certificate is altered
# it blindly installs all certificates in an ubuntu system

# Create the certs subdirectory if it does not exist
mkdir -p certs

# Read the hosts.txt file line by line
while IFS= read -r host
  do
    # Skip empty lines or lines starting with #
    if [[ -z "$host" || "$host" =~ ^# ]]; then
      continue
    fi

    # Extract and save the certificate
    echo "Downloading certificate for $host..."
    echo | openssl s_client -showcerts -servername "$host" -connect "$host":443 2>/dev/null | \
      openssl x509 -outform PEM -out "certs/$host.crt"
  done < hosts.txt

echo "Certificates saved in the 'certs' directory."


sudo cp certs/*.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
