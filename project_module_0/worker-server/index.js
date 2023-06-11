"use strict";
require("dotenv").config();
const { createClient } = require("redis");
const mysql = require("mysql2");

// redis
const redisUsername = process.env.REDIS_USERNAME || "";
const redisPassword = process.env.REDIS_PASSWORD || "mypassword";
const redisHost = process.env.REDIS_HOST || "redis-pubsub";
const redisPort = process.env.REDIS_PORT || 6379;
const redisChannel = process.env.REDIS_CHANNEL || "channel1";

// mysql
const sqlHost = process.env.MYSQL_HOST || "127.0.0.1";
const sqlUser = process.env.MYSQL_USERNAME || "root";
const sqlPassword = process.env.MYSQL_PASSWORD || "password";
const sqlDatabase = process.env.MYSQL_DATABASE || "mydb";
const sqlTable = process.env.MYSQL_TABLE || "mytable";

const subscriber = createClient({
  url: `redis://${redisUsername}:${redisPassword}@${redisHost}:${redisPort}`,
});

// get the client

// create the connection to database
const sqlConnection = mysql.createConnection({
  host: sqlHost,
  user: sqlUser,
  password: sqlPassword,
  database: sqlDatabase,
});

// for debug purpose
// console.log({ port, username, password, redisHost, redisPort, channel });

(async function () {
  try {
    await subscriber.connect();
    subscriber.on("error", (err) => console.log("Redis error", err));
    subscriber.on("connect", () => console.log("\n Connected to Redis \n"));
    subscriber.on("ready", () => console.log("\n Redis ready for action! \n"));
    subscriber.on("reconnecting", () => {
      console.log("\nReconnecting to Redis...\n");
    });

    // the call back fn is required
    await subscriber.subscribe(redisChannel, (message) => {
      console.log(message);
      sqlConnection.connect(function (err) {
        if (err) throw err;
        console.log("Connected!");
        const sql =
        `INSERT INTO ${sqlTable} (data) VALUES ('${data}')`;
        sqlConnection.query(sql, function (err, result) {
          if (err) throw err;
          console.log("1 record inserted");
        });
      });
    });
  } catch (error) {
    // exited the reconnection logic
    console.error({ error });
  }
})();
