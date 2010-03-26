#!/usr/bin/env bash

rm pkgs/cookbooks.tgz
rake bundle
ln -sf ~/.s3cfg-hw ~/.s3cfg
s3cmd put pkgs/cookbooks.tgz --acl-public s3://hw-public/cookbooks.tgz
