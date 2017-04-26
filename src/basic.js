import 'babel-polyfill';
import serverSettings from './server-settings';
import redis from 'redis';

var client = redis.createClient(serverSettings);

client.set('randomKey1', 'some value', function(err, reply) {
    console.log(reply);
});
