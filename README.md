# Fluxguard API Test Script

This Bash script is designed to interact with the Fluxguard API to manage web crawling and account data retrieval tasks. It allows you to:

- Fetch Account Data: The script can query the Fluxguard API to retrieve and display information about your account.

- Initiate Crawl: It can initiate a web crawl for a specific site and session by making an API request to Fluxguard. After a short time, a function is called that gets data about the page after the crawl in JSON format. The JSON response is parsed using 'jq' so specific pieces of data is shown in the console.

The script uses environment variables for configuration, making it flexible and secure. Flags can be passed when invoking the script to selectively run specific functions.

## Environment Variables

- FLUXGUARD_API_KEY = your_api_key_here
- FLUXGUARD_SITE_ID = your_site_id_here
- FLUXGUARD_SESSION_ID = your_session_id_here
- FLUXGUARD_PAGE_ID = your_page_id_here