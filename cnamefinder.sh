#!/bin/bash

while getopts "f:o:v" opt; do
  case $opt in
    f)
      input_file="$OPTARG"
      ;;
    o)
      output_file="$OPTARG"
      ;;
    v)
      verbose=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ -z "$input_file" ] || [ -z "$output_file" ]; then
  echo "Usage: $0 -f <input_file> -o <output_file> -v verbose mode"
  exit 1
fi

echo "Working..."
while IFS= read -r subdomain; do
    # Run dig and search for CNAME records
    cname=$(dig +short +noshort +answer -t CNAME "$subdomain" | grep -o 'CNAME.*' | cut -d ' ' -f 2)
    
    # If CNAME record found, save the entire dig output to the output file
    if [ -n "$cname" ]; then
        dig_output=$(dig +short +noshort +answer "$subdomain")
        echo "Results for $subdomain:" >> "$output_file"
        echo "$dig_output" >> "$output_file"
        echo "========================" >> "$output_file"
        
        if [ "$verbose" = true ]; then
          echo "Verbose output for $subdomain:"
          echo "$dig_output"
        fi
    fi
done < "$input_file"

echo "Dig output for subdomains with CNAME records has been saved to $output_file"
