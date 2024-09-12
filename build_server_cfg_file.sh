#!/bin/bash

echo "Checking for $VERSION files..."
if [[ ! -d "/terraria/$VERSION" ]]; then
  echo "No matching server found. Downloading..."
  cd /terraria/.tmp
  wget -c https://terraria.org/api/download/pc-dedicated-server/terraria-server-$VERSION.zip
  unzip terraria-server-$VERSION.zip
  cd $VERSION
  mv Linux/* .
  rm -rf Mac Windows System* Mono* monoconfig mscorlib.dll
  chmod +x TerrariaServer*
  mv /terraria/.tmp/$VERSION /terraria/.
  rm -rf /terraria/.tmp/*
fi

echo "Building config file..."
cd /terraria/$VERSION
echo "worldpath=/terraria/worlds" > serverconfig.txt
echo "world=/terraria/worlds/${WORLD:-world}.wld" >> serverconfig.txt
echo "worldname=${WORLD:-world}" >> serverconfig.txt
echo "autocreate=${SIZE:-1}" >> serverconfig.txt
echo "difficulty=${DIFFICULTY:-2}" >> serverconfig.txt
echo "motd=${MOTD:-Nice Terraria Server}" >> serverconfig.txt
if [[ -n "$SEED" ]]; then
  echo "seed=${SEED}" >> serverconfig.txt
fi
if [[ -n "$PASSWORD" ]]; then
  echo "password=${PASSWORD}" >> serverconfig.txt
fi

mono --server --gc=sgen -O=all /terraria/$VERSION/TerrariaServer.exe -config serverconfig.txt
