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

# Check for a title inside the mermaid block
if ! awk '/```mermaid/{flag=1; next} /```/{flag=0} flag' "$FILE" | grep -q 'title '; then
    echo "❌ Missing title declaration in diagram"
    exit 1
fi

# Check for Rel statements with intent
if grep -Eq 'Rel\(.*,.*, *"(Uses|Calls|Reads)"' "$FILE"; then
    echo "❌ Found forbidden bare intent in Rel statement (e.g., \"Uses\", \"Calls\", \"Reads\"). Labels must be descriptive intents."
    exit 1
fi

# Check for invalid boundary syntax (appending { to a System or Container)
if grep -Eq '^[[:space:]]*(System|SystemDb|SystemQueue|Container|ContainerDb|ContainerQueue)\(.*[[:space:]]*\{' "$FILE"; then
    echo "❌ Found invalid boundary syntax. You cannot append '{' to a System or Container. You must use System_Boundary or Container_Boundary."
    exit 1
fi

# Extract and check elements for type and technology
if grep -Eq 'C4Container|C4Component' "$FILE"; then
    while read -r line; do
        if [[ "$line" =~ ^[[:space:]]*(Container|ContainerDb|ContainerQueue)\( ]]; then
            commas=$(echo "$line" | tr -cd ',' | wc -c)
            if [ "$commas" -lt 3 ]; then
                echo "❌ Found Container missing technology parameter: $line"
                exit 1
            fi
        fi
        if [[ "$line" =~ ^[[:space:]]*(Rel|Rel_U|Rel_D|Rel_L|Rel_R)\( ]]; then
            commas=$(echo "$line" | tr -cd ',' | wc -c)
            if [ "$commas" -lt 3 ]; then
                echo "❌ Found Rel statement missing protocol parameter: $line"
                exit 1
            fi
            
            # Check for undefined aliases
            from_alias=$(echo "$line" | sed -E 's/^[[:space:]]*Rel[A-Za-z_]*\(([A-Za-z0-9_]+)[[:space:]]*,[[:space:]]*([A-Za-z0-9_]+).*/\1/')
            to_alias=$(echo "$line" | sed -E 's/^[[:space:]]*Rel[A-Za-z_]*\(([A-Za-z0-9_]+)[[:space:]]*,[[:space:]]*([A-Za-z0-9_]+).*/\2/')
            
            if ! grep -q -E "\($from_alias[,\)]" "$FILE"; then
                echo "❌ Found undefined alias '$from_alias' in Rel statement. This causes Mermaid to crash with 'Cannot read properties of undefined (reading x)'. Line: $line"
                exit 1
            fi
            if ! grep -q -E "\($to_alias[,\)]" "$FILE"; then
                echo "❌ Found undefined alias '$to_alias' in Rel statement. This causes Mermaid to crash with 'Cannot read properties of undefined (reading x)'. Line: $line"
                exit 1
            fi
        fi
    done < "$FILE"
fi

exit 0
