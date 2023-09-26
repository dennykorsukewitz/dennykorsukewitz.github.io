#!/bin/bash

# ---
# Start Pages
# ---
# .github/workflows/pages/pages.sh

# ---
# Step: Delete all
# ---
echo -e "\n-----------START delete-----------\n"
.github/workflows/pages/delete.sh

# ---
# Step: Create _data/files
# ---
echo -e "\n-----------START data-----------\n"
.github/workflows/pages/data.sh

# ---
# Step: Add dennykorsukewitz (GitHub Profile)
# ---
echo -e "\n-----------START github-profile-----------\n"
.github/workflows/pages/github-profile.sh

# ---
# Step: Add Repository List
# ---
echo -e "\n-----------START repositories-----------\n"
.github/workflows/pages/repositories.sh

# ---
# Step: Add Repository Tab
# ---
echo -e "\n-----------START repositories_tab-----------\n"
.github/workflows/pages/repositories_tab.sh

# ---
# Step: Create release blog posts
# ---
echo -e "\n-----------START posts-----------\n"
.github/workflows/pages/posts.sh

# ---
# Step: Add Monitoring
# ---
echo -e "\n-----------START Monitoring-----------\n"
.github/workflows/pages/monitoring.sh

echo -e "\n-----------START jekyll-----------\n"
git jekyll-init-serve