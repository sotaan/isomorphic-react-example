#!/bin/bash

# Change to bin
cd $(dirname $([ -L $0 ] && readlink -f $0 || echo $0))
# Then change up
cd ../

# Update deps
npm install

# Start Meteor backend
cd app/backend
MONGO_URL=mongodb://localhost:27017/isomorphic-react meteor &
cd ../../

# Start dev server
webpack-dev-server -h --port 7007 -c --progress --config ./webpack.config.js --devtool eval &
nodemon ./app/server/index.js

trap "kill 0" SIGINT SIGTERM EXIT

wait