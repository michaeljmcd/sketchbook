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
var publisher = redis.createClient(serverSettings);

client.on('message', function(channel, message) {
    console.log(message);
    process.exit();
});

client.on('subscribe', function(channel, message) {
    publisher.set('randomKey1', 3 ** 3, function(channel, message) {
        console.log('set randomKey1.');
    });
});

client.subscribe('__keyspace@0__:randomKey1');
