#!/bin/bash

# Script to download student PDFs for CIT-227
# Downloads provisional results for students 001 to 032

# Base URL pattern
BASE_URL="https://studentportal.mmu.ac.ke/Student%20Downloads/PROVISIONAL%20RESULTS-CIT-227-"
URL_SUFFIX="2021.pdf"

# Create directory for downloads if it doesn't exist
mkdir -p student_pdfs
cd student_pdfs

echo "Starting download of student PDFs..."
echo "Downloading for students 001 to 032"
echo "======================================"

# Counter for successful downloads
success_count=0
failed_count=0

# Loop through student numbers 1 to 32
for i in {1..32}; do
    # Format number with leading zeros (3 digits)
    student_num=$(printf "%03d" $i)
    
    # Construct full URL
    full_url="${BASE_URL}${student_num}${URL_SUFFIX}"
    
    # Construct filename
    filename="student_${student_num}_CIT-227.pdf"
    
    echo "Downloading: $filename"
    
    # Download with curl
    # -L follows redirects
    # -o specifies output filename
    # -f fails silently on HTTP errors
    # --connect-timeout sets connection timeout
    # --max-time sets maximum time for the operation
    if curl -L -f -o "$filename" "$full_url" --connect-timeout 30 --max-time 60 --silent; then
        echo "✓ Successfully downloaded: $filename"
        ((success_count++))
    else
        echo "✗ Failed to download: $filename"
        ((failed_count++))
        # Remove empty file if download failed
        [ -f "$filename" ] && rm "$filename"
    fi
    
    # Small delay to be respectful to the server
    sleep 1
done

echo "======================================"
echo "Download Summary:"
echo "Successful downloads: $success_count"
echo "Failed downloads: $failed_count"
echo "Total attempts: 101"
echo "Files saved in: $(pwd)"
echo "======================================"
