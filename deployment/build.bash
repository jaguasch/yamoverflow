#!/bin/bash -e
RELEASE=`date +%d%m%y%H%M`
APPID="yamoverflow"
DEPLOY_ROOT="/opt/$APPID"
DEPLOY_TARGET="$DEPLOY_ROOT/$RELEASE"
OWNER="yamoverflow:yamoverflow"
RUBY_VERSION="2.0.0"
RVM="/usr/local/rvm/bin/rvm"

echo "Setting up environment via puppet..."
puppet apply deployment/environment.pp

echo "Setting up ruby version"
$RVM install $RUBY_VERSION  

echo "Packaging release $RELEASE..."
bundle package --all

echo "Copying to $DEPLOY_TARGET"
mkdir -p  $DEPLOY_TARGET
rsync -a . $DEPLOY_TARGET/
chown -R $OWNER $DEPLOY_TARGET