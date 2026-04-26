#!/bin/bash
set -e

# Usage: ./validate-c4-diagram.sh <path-to-markdown-file>

FILE=$1

if [ -z "$FILE" ]; then
    echo "Usage: $0 <path-to-markdown-file>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "❌ File not found: $FILE"
    exit 1
fi

echo "Validating C4 Diagram syntax in: $FILE"

# Check for mermaid code block
if ! grep -q '```mermaid' "$FILE"; then
    echo "❌ Missing \`\`\`mermaid code block"
    exit 1
fi

# Check for valid C4 graph type
if ! grep -Eq 'C4Context|C4Container|C4Component|C4Dynamic|C4Deployment' "$FILE"; then
    echo "❌ Missing C4 graph type declaration (e.g., C4Context, C4Container, etc.) inside mermaid block"
    exit 1
fi

# Check for a title
if ! grep -q 'title ' "$FILE"; then
    echo "❌ Missing title declaration in diagram"
    exit 1
fi

# Check for Rel statements with intent
if grep -Eq 'Rel\(.*,.*, *"(Uses|Calls|Reads)"' "$FILE"; then
    echo "❌ Found forbidden bare intent in Rel statement (e.g., \"Uses\", \"Calls\", \"Reads\"). Labels must be descriptive intents."
    exit 1
fi

# Extract and check elements for type and technology
if grep -Eq 'C4Container|C4Component' "$FILE"; then
    while read -r line; do
        if [[ "$line" =~ ^[[:space:]]*Container(|Db|Queue)\( ]]; then
            commas=$(echo "$line" | tr -cd ',' | wc -c)
            if [ "$commas" -lt 3 ]; then
                echo "❌ Found Container missing technology parameter: $line"
                exit 1
            fi
        fi
        if [[ "$line" =~ ^[[:space:]]*Rel(|_U|_D|_L|_R)\( ]]; then
            commas=$(echo "$line" | tr -cd ',' | wc -c)
            if [ "$commas" -lt 3 ]; then
                echo "❌ Found Rel statement missing protocol parameter: $line"
                exit 1
            fi
        fi
    done < "$FILE"
fi

echo "✅ $FILE is a valid C4 Markdown diagram"
exit 0
