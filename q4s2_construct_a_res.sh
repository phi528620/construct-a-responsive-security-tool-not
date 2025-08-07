#!/bin/bash
#
# Project: Construct a Responsive Security Tool Notifier
# Description: A bash script that monitors system logs for security threats and notifies the admin via email
# Author: [Your Name]

# Set variables
LOG_FILE="/var/log/auth.log"
THREAT_KEYWORDS=("failed" "unauthorized" "denied")
ADMIN_EMAIL="admin@example.com"

# Function to monitor logs and detect threats
detect_threats() {
  echo "Monitoring $LOG_FILE for security threats..."
  while IFS= read -r line; do
    for keyword in "${THREAT_KEYWORDS[@]}"; do
      if echo "$line" | grep -iq "$keyword"; then
        notify_admin "$line"
      fi
    done
  done < "$LOG_FILE"
}

# Function to send notification to admin
notify_admin() {
  echo "Security threat detected: $1"
  echo "Subject: Security Threat Detected" >> notification.txt
  echo "Security threat detected: $1" >> notification.txt
  echo "" >> notification.txt
  /usr/sbin/sendmail -t -i $ADMIN_EMAIL < notification.txt
  rm notification.txt
}

# Main program
echo "Responsive Security Tool Notifier started..."
detect_threats
echo "Notifier stopped. Exiting..."