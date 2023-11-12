# cnamefinder
Simple utility for finding CNAME's in a long list of subdomains. Useful for subdomain takoevers

Usage:
```
-f <input_file> -o <output_file> -v verbose mode
```

Instructions:
```
git clone https://github.com/dadsgone0/cnamefinder.git
cd cnamefinder
sudo chmod 700 cnamefinder.sh
./cnamefinder.sh
```
Input file formatting:
```
subdomain.example.com
subdomain2.example.org
subdomain3.example.gov
```
(Also works for apex domains)
