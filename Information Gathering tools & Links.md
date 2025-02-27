📡  Google Dorking  🎯

```
https://vijays1808.github.io/Advanced-google-dorking/
```
```
https://nmochea.github.io/dorker.github.io/
```
```
https://taksec.github.io/google-dorks-bug-bounty/
```
```
https://dorkking.blindf.com/
```
```
https://dorks.s1rn3tz.ovh/googledorks
```
🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅

📡   Github Dorking 🎯
```
https://vsec7.github.io/
```
🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅

📡  Shodan Dorker 🎯
```
https://dorks.s1rn3tz.ovh/shodandorks
```
```
https://dorks.s1rn3tz.ovh/shodandorks
```
🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅

📡   Information Gathering 🎯
```
https://freelancermijan.github.io/reconengine/
```
🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅🏅

📡   Gather links from robots.txt file:
```
curl -s https://www.protoexpress.com/robots.txt | grep -i "Disallow" | awk '{print $2}'
```
```
https://github.com/Josue87/roboxtractor.git
```
```
https://github.com/SoreOff/RoboX.git
```
 ## Gf Collection:

 https://github.com/emadshanab/Gf-Patterns-Collection.git

 ## Find the endpoint from source code:
```
 import re
import requests

# Function to fetch the source code of a webpage
def get_source_code(url):
    headers = {"User-Agent": "Mozilla/5.0"}
    response = requests.get(url, headers=headers)
    return response.text if response.status_code == 200 else None

# Function to extract sensitive data using regex
def extract_sensitive_data(source_code):
    patterns = {
        "API Keys": r"(?:api_key|apikey|API_KEY|token|access_token)[\"']?\s*[:=]\s*[\"']([A-Za-z0-9_\-]{10,})[\"']",
        "Authorization Headers": r"Authorization:\s*Bearer\s+([A-Za-z0-9_\-]+)",
        "Endpoints": r"https?:\/\/[a-zA-Z0-9./?=_-]+",
        "JWT Tokens": r"eyJ[a-zA-Z0-9_-]{10,}\.[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+",
    }
    
    extracted_data = {}
    for key, pattern in patterns.items():
        matches = re.findall(pattern, source_code)
        extracted_data[key] = matches if matches else "Not found"
    
    return extracted_data

# Main function
def main():
    url = input("Enter the webpage URL: ")
    source_code = get_source_code(url)
    
    if source_code:
        extracted_data = extract_sensitive_data(source_code)
        for key, values in extracted_data.items():
            print(f"\n🔍 {key}:")
            print(values if values != "Not found" else "❌ No data found")
    else:
        print("❌ Failed to fetch the webpage.")

if __name__ == "__main__":
    main()
```














💯    💯
