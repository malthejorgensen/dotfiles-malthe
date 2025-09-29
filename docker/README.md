

Install
-------
The current recommended setup is to use [colima]

brew install colima
brew install docker
brew install docker-compose

docker-compose
--------------
You can run `brew info docker-compose` to get the following information:

    Compose is a Docker plugin. For Docker to find the plugin, add "cliPluginsExtraDirs" to ~/.docker/config.json:
      "cliPluginsExtraDirs": [
          "/opt/homebrew/lib/docker/cli-plugins"
      ]

this has already been added to `./config.json` in this directory.

[colima]: https://github.com/abiosoft/colima
