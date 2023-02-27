#!/bin/bash

REPOSITORIES='dennykorsukewitz DK4 DK4Znuny-VisualStudioCode DK4Znuny-QuickDelete DK4OTRS-UBInventory MRBS-OTRS'
REPOSITORIES=($(echo "$REPOSITORIES"))

for REPOSITORY in "${REPOSITORIES[@]}"; do
  echo "Delete: $REPOSITORY"
  rm -Rf $REPOSITORY
done

rm -f _posts/*