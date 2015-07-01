# minimal-deploy
A minimal nodejs server to execute shell commands when hit with HTTP requests having plaintext password

# Installation
This project doesnt have any dependency, so just git clone this repo or download zip.

    git clone https://github.com/1upon0/minimal-deploy

Then edit `config.sample.coffee` to your desire and rename it to `config.coffee`

You can start it with `coffee index.coffee`, or better use `pm2 start index.coffee` to ensure it is always available. Proxy-ing via `nginx` is recommended to add https and/or basic-auth.

# Usage
The URL structure is: `http://localhost:4000/{project-name}/{password}/{action}`

where action can be: `status` or `deploy`

Add a push POST hook to your repo for the deploy action, and check its status at the status action. Easy.