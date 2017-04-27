## redis-experiments

It's what it says on the tin - experiments with a Redis cache as part of a larger proof-of-concept. Probably not intrinsically useful, but licensed under the MIT license.

The code is written in ES6, so you probably need to run `npm run compile` before executing the scripts. After compilation, copy `example-server-settings.json` to `server-settings.json` and modify it to have the details for your Redis server. The defaults will work if you have a server running on the same machine.

Each example has been added to the scripts list.

* `npm run basic`
* `npm run promises`
