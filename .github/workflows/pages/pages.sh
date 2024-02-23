#!/opt/homebrew/bin/bash

# ---
# Start Pages
# ---
# /opt/homebrew/bin/bash .github/workflows/pages/pages.sh

# ---
# Step: Delete all
# ---
echo -e "\n-----------START delete-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/delete.sh

# ---
# Step: Create _data/files
# ---
echo -e "\n-----------START data-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/data.sh

# ---
# Step: Add dennykorsukewitz (GitHub Profile)
# ---
echo -e "\n-----------START github-profile-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/github-profile.sh

# ---
# Step: Add Repository List
# ---
echo -e "\n-----------START repositories-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/repositories.sh

# ---
# Step: Add Repository Tab
# ---
echo -e "\n-----------START repositories_tab-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/repositories_tab.sh

# ---
# Step: Create release blog posts
# ---
echo -e "\n-----------START posts-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/posts.sh

# ---
# Step: Add Monitoring
# ---
echo -e "\n-----------START Monitoring-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/monitoring.sh

# ---
# Step: Add Pipelines
# ---
echo -e "\n-----------START Pipelines-----------\n"
/opt/homebrew/bin/bash .github/workflows/pages/pipelines.sh

echo -e "\n-----------START jekyll-----------\n"
# git jekyll-init-serve