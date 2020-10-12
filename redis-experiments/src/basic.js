import 'babel-polyfill';
import redis from 'redis';
import fs from 'fs';
import path from 'path';

var configPath = path.join(__dirname, '../server-settings.json');
var serverSettings = JSON.parse(fs.readFileSync(configPath, 'utf8'));

var client = redis.createClient(serverSettings);

client.set('randomKey1', 'some value', function(err, reply) {
    console.log(reply);

    client.get('randomKey1', function(err, reply) {
        console.log(reply.toString());
        process.exit();
    });
});
