#!/usr/bin/env bash
# Convert SQL Server connection strings to vim-dadbod-ui format
#
# Usage:
#   convert-sql-connection.sh "Server=..."
#   echo "Server=..." | convert-sql-connection.sh

set -euo pipefail

# Read from argument or stdin
if [[ $# -eq 0 ]]; then
    read -r connection_string
else
    connection_string="$1"
fi

# Parse connection string components
url=""
port=""
catalog=""
encrypt=""
trust_cert=""
auth="ActiveDirectoryDefault"

# Split by semicolon and parse each key=value pair
IFS=';' read -ra PARTS <<< "$connection_string"
for part in "${PARTS[@]}"; do
    # Skip empty parts
    [[ -z "${part// /}" ]] && continue
    
    # Split key=value
    IFS='=' read -r key value <<< "$part"
    
    # Trim whitespace
    key="${key// /}"
    value="${value// /}"
    
    case "$key" in
        Server)
            # Split URL,PORT
            IFS=',' read -r url port <<< "$value"
            ;;
        "Initial Catalog"|InitialCatalog)
            catalog="$value"
            ;;
        Encrypt)
            encrypt="${value,,}"  # lowercase
            ;;
        TrustServerCertificate)
            trust_cert="${value,,}"  # lowercase
            ;;
        Authentication)
            auth="$value"
            ;;
    esac
done

# Validate required fields
if [[ -z "$url" ]]; then
    echo "Error: Server URL not found in connection string" >&2
    exit 1
fi

if [[ -z "$catalog" ]]; then
    echo "Error: Initial Catalog not found in connection string" >&2
    exit 1
fi

# Build vim-dadbod-ui connection string
dadbod_url="sqlserver://${url}"

# Add port if present
if [[ -n "$port" ]]; then
    dadbod_url="${dadbod_url}:${port}"
fi

# Add catalog
dadbod_url="${dadbod_url}/${catalog}"

# Build query parameters
query_params=()
[[ -n "$encrypt" ]] && query_params+=("Encrypt=${encrypt}")
[[ -n "$trust_cert" ]] && query_params+=("trustServerCertificate=${trust_cert}")
[[ -n "$auth" ]] && query_params+=("authentication=${auth}")

# Append query parameters if any exist
if [[ ${#query_params[@]} -gt 0 ]]; then
    # Join array with &
    IFS='&' eval 'query_string="${query_params[*]}"'
    dadbod_url="${dadbod_url}?${query_string}"
fi

echo "$dadbod_url"
