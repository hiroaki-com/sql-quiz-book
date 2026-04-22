#!/bin/bash

set -euo pipefail

INDEX_FILE="docs/index.html"
FILES_DIR="docs/files"

mkdir -p "$(dirname "$INDEX_FILE")"

cat << 'EOF' > "$INDEX_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SQL Quiz Book Index</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      max-width: 720px;
      margin: 40px auto;
      padding: 0 16px;
      line-height: 1.6;
      background-color: #121212;
      color: #e0e0e0;
    }
    h1 {
      margin-bottom: 24px;
      padding-bottom: 8px;
      border-bottom: 1px solid #333;
    }
    ul { padding-left: 24px; }
    li { margin-bottom: 6px; }
    a { text-decoration: none; color: #58a6ff; }
    a:hover { text-decoration: underline; color: #79b8ff; }
  </style>
</head>
<body>
  <h1>SQL Quiz Book Index</h1>
  <ul>
EOF

shopt -s nullglob
export LC_ALL=C

files=("$FILES_DIR"/*.html)

if[ "${#files[@]}" -gt 0 ]; then
  for file in "${files[@]}"; do
    filename="$(basename "$file")"
    display_name="${filename%.html}"
    echo "    <li><a href=\"files/$filename\">$display_name</a></li>" >> "$INDEX_FILE"
  done
else
  echo "    <li>No quiz files available at the moment.</li>" >> "$INDEX_FILE"
fi

cat << 'EOF' >> "$INDEX_FILE"
  </ul>
</body>
</html>
EOF

echo "✅ docs/index.html generated successfully."
