#!/bin/bash

set -o allexport
source .env
set +o allexport

BASE_URL="https://api.fluxguard.com"
ACCOUNT_ROUTE="/account"
CRAWL_ROUTE="/site/$FLUXGUARD_SITE_ID/session/$FLUXGUARD_SESSION_ID/crawl"
PAGE_ROUTE="/site/$FLUXGUARD_SITE_ID/session/$FLUXGUARD_SESSION_ID/page/$FLUXGUARD_PAGE_ID"

get_account_data() {
    curl -s -S -H "x-api-key: $FLUXGUARD_API_KEY" "$BASE_URL$ACCOUNT_ROUTE"
}

initiate_crawl() {
    curl -s -S -X POST -H "x-api-key: $FLUXGUARD_API_KEY" "$BASE_URL$CRAWL_ROUTE"
}

get_page_data() {
    curl -s -S -H "x-api-key: $FLUXGUARD_API_KEY" "$BASE_URL$PAGE_ROUTE" | jq -r '.lastCapture.diffSummary'
}

while getopts ":achp" opt; do
    case $opt in
        a)
            echo "Fetching Account Data..."
            account_data=$(get_account_data)
            echo "Account Data:"
            echo $account_data
        ;;
        c)
            echo "Initiating Crawl..."
            crawl_response=$(initiate_crawl)
            echo "Waiting for crawl to complete..."
            sleep 120
            echo "Fetching Diff Results..."
            diff_summary=$(get_page_data)
            echo "Diff Results:"
            echo $diff_summary
        ;;
        h)
            echo "Usage: ./script.sh [options]"
            echo "Options:"
            echo "  -a    Fetch account data"
            echo "  -c    Initiate and fetch crawl data"
            echo "  -h    Show help information"
        ;;
        \?)
            echo "Invalid option -$OPTARG" >&2
            exit 1
        ;;
    esac
done

if [ $# -eq 0 ]; then
    echo "Usage: ./script.sh [options]"
    echo "Options:"
    echo "  -a    Fetch account data"
    echo "  -c    Initiate and fetch crawl data"
    echo "  -h    Show help information"
fi
