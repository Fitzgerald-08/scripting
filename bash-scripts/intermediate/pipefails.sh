#!/bin/bash
set -euxo pipefail

echo "Hello, this message should be executed" | GREP "executed" | echo "pipefail ends here"

echo "But, will this message be printed in the terminal"; ls
