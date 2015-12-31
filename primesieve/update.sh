#!/usr/bin/env bash

this=$(dirname $0)

set -e

. $this/primesieve_url.sh
$this/../scripts/run.sh primesieve
