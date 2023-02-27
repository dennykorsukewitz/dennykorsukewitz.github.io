#!/bin/bash

# ---
# Step: Delete all
# ---
echo -e "\n-----------START delete-----------\n"
.github/workflows/pages/delete.sh

# ---
# Step: Add dennykorsukewitz (GitHub Profile)
# ---
echo -e "\n-----------START github-profile-----------\n"
.github/workflows/pages/github-profile.sh

# ---
# Step: Add Repository List
# ---
echo -e "\n-----------START repository-----------\n"
.github/workflows/pages/repository.sh

# ---
# Step: Add Repository List
# ---
echo -e "\n-----------START posts-----------\n"
.github/workflows/pages/posts.sh


echo -e "\n-----------START jekyll-----------\n"
git jekyll-init-serve