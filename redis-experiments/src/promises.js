import 'babel-polyfill';
import redis from 'redis';
import fs from 'fs';
import path from 'path';
import bluebird from 'bluebird';

var configPath = path.join(__dirname, '../server-settings.json');
var serverSettings = JSON.parse(fs.readFileSync(configPath, 'utf8'));

bluebird.promisifyAll(redis.RedisClient.prototype);
bluebird.promisifyAll(redis.Multi.prototype);

var client = redis.createClient(serverSettings);

client.multi().get('randomKey1').execAsync().then(function(res) {
        console.log(res);
        process.exit();
});
