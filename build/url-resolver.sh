#!/bin/sh
LIST_URL='http://launchermeta.mojang.com/mc/game/version_manifest.json'

VERSION=${1:?}

MANIFEST_URL=`curl -s $LIST_URL | jq -r ".versions[] | select(.id==\"$VERSION\") .url"`
JAR_URL=`curl -s $MANIFEST_URL | jq -r ".downloads .server .url"`

echo $JAR_URL
