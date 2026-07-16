#!/bin/bash

set -e

# Regression test for trixie-compatible key handling (issue #90):
# the upstream `ghcr.io/dhoeric/features/google-cloud-cli` feature uses
# `apt-key`, which was removed in Debian 13 (trixie), so the build fails
# with `apt-key: command not found`. This scenario proves our fork installs
# cleanly on trixie by reaching this script at all.

./_default.sh
