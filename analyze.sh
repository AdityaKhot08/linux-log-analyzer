#!/bin/bash
# Linux Log Analyzer - analyze.sh
# Generates report.txt summarizing errors and warnings.
# Designed to run on Ubuntu-like systems. Handles missing log files gracefully.

OUTPUT="report.txt"
LOG1="/var/log/syslog"
LOG2="/var/log/messages"

echo "===== Linux Log Analysis Report =====" > "$OUTPUT"
echo "Generated on: $(date '+%Y-%m-%d %H:%M:%S %Z')" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Choose available log file
if [ -f "$LOG1" ]; then
    LOGFILE="$LOG1"
elif [ -f "$LOG2" ]; then
    LOGFILE="$LOG2"
else
    echo "No system log file found at $LOG1 or $LOG2." >> "$OUTPUT"
    echo "If running on GitHub Actions, sample logs will be used." >> "$OUTPUT"
    LOGFILE=""
fi

if [ -n "$LOGFILE" ]; then
    echo "Analyzing log file: $LOGFILE" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Top 15 ERROR lines:" >> "$OUTPUT"
    grep -i "error" "$LOGFILE" | tail -n 15 >> "$OUTPUT" 2>/dev/null || echo "(no errors found)" >> "$OUTPUT"

    echo "" >> "$OUTPUT"
    echo "Top 15 WARNING lines:" >> "$OUTPUT"
    grep -i "warning" "$LOGFILE" | tail -n 15 >> "$OUTPUT" 2>/dev/null || echo "(no warnings found)" >> "$OUTPUT"

    echo "" >> "$OUTPUT"
    echo "Total ERROR count:" >> "$OUTPUT"
    grep -ic "error" "$LOGFILE" 2>/dev/null || echo "0" >> "$OUTPUT"

    echo "" >> "$OUTPUT"
    echo "Total WARNING count:" >> "$OUTPUT"
    grep -ic "warning" "$LOGFILE" 2>/dev/null || echo "0" >> "$OUTPUT"
else
    # Create sample content to demonstrate report generation (useful on CI)
    echo "Sample logs (CI environment) used for demo." >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "Top 10 Sample ERROR lines:" >> "$OUTPUT"
    for i in {1..5}; do echo "Dec 11 12:0$i sample-host sample-service: ERROR Sample error message $i"; done >> "$OUTPUT"

    echo "" >> "$OUTPUT"
    echo "Top 10 Sample WARNING lines:" >> "$OUTPUT"
    for i in {1..3}; do echo "Dec 11 12:0$i sample-host sample-service: WARNING Sample warning $i"; done >> "$OUTPUT"

    echo "" >> "$OUTPUT"
    echo "Total ERROR count:" >> "$OUTPUT"
    echo "5" >> "$OUTPUT"

    echo "" >> "$OUTPUT"
    echo "Total WARNING count:" >> "$OUTPUT"
    echo "3" >> "$OUTPUT"
fi

echo "" >> "$OUTPUT"
echo "Report generation complete. (This file is suitable for upload or hosting.)" >> "$OUTPUT"
