#!/bin/bash

WORK_DIR="/home/onyxia/work"
CLONE_DIR="${WORK_DIR}/cours-nouvelles-donnees-site"

# Clone site repository
REPO_URL="https://github.com/InseeFrLab/cours-nouvelles-donnees-site.git"
git clone --depth 1 $REPO_URL $CLONE_DIR

# Install requirements
pip install -r $CLONE_DIR/requirements.txt
./$CLONE_DIR/download_nlp_reqs.sh

# Remove useless repository
rm -rf $CLONE_DIR
