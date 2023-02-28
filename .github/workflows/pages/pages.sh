#!/bin/bash

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
# Step: Add Repository List
# ---
echo -e "\n-----------START posts-----------\n"
.github/workflows/pages/posts.sh


echo -e "\n-----------START jekyll-----------\n"
git jekyll-init-serve