"use strict";
import dotenv from "dotenv";
import express from "express";
import cors from "cors";
import { createClient } from "redis";
import mysql from "mysql2/promise";

dotenv.config();
// environment variables
const expressPort = process.env.PORT || 5001;

// redis
const redisUsername = process.env.REDIS_USERNAME || "";
const redisPassword = process.env.REDIS_PASSWORD || "mypassword";
const redisHost = process.env.REDIS_HOST || "redis";
const redisPort = process.env.REDIS_PORT || 6379;
const redisChannel = process.env.REDIS_CHANNEL || "channel1";

// mysql
const sqlHost = process.env.MYSQL_HOST || "db";
const sqlUser = process.env.MYSQL_USERNAME || "root";
const sqlPassword = process.env.MYSQL_PASSWORD || "password";
const sqlDatabase = process.env.MYSQL_DATABASE || "mydb";
const sqlTable = process.env.MYSQL_TABLE || "todos";

// configs
const redisUrl = `redis://${redisUsername}:${redisPassword}@${redisHost}:${redisPort}`;
const dbConfig = {
  host: sqlHost,
  user: sqlUser,
  password: sqlPassword,
  database: sqlDatabase,
};

const redisClient = createClient({ url: redisUrl });

const getData = async () => {
  const sqlQuery = `SELECT * FROM ${sqlTable}`;
  const sqlConnection = await mysql.createConnection(dbConfig);
  return sqlConnection.execute(sqlQuery);
};

const setRedisCache = async (jsonData) => {
  const value = JSON.stringify({ isCached: "yes", data: jsonData });
  await redisClient.connect();
  await redisClient.set("key", value);
  return redisClient.disconnect();
};

const getRedisCache = async () => {
  await redisClient.connect();
  const cachedData = await redisClient.get("key");
  await redisClient.disconnect();
  return cachedData;
};

const deleteRedisCache = async () => {
  await redisClient.connect();
  await redisClient.del("key");
  return redisClient.disconnect();
};

const publishToRedis = async (data) => {
  await redisClient.connect();
  const subscriberCount = await redisClient.publish(redisChannel, data);
  await redisClient.disconnect();
  return subscriberCount;
};

//express
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// express endpoints
app.get("/", (_, res) => res.status(200).send("connected to server 1!"));
app.get("/todo", async (_, res) => {
  try {
    const cachedData = await getRedisCache();
    if (cachedData) {
      const results = JSON.parse(cachedData);
      res.status(200).json({ message: "success", ...results });
      return;
    }

    const [data, _] = await getData();
    await setRedisCache(data);

    res.status(200).json({ message: "success", isCached: "no", data });
  } catch (error) {
    console.log({ error });
    res.status(500).json({ message: "failure", error });
  }
});

app.post("/create", async (req, res) => {
  const { data } = req.body;
  try {
    if (!data) throw new Error("missing data");
    const subscriberCount = await publishToRedis(data);
    console.log({ subscriberCount });
    const test = await deleteRedisCache();
    res.status(200).json({ message: "success" });
  } catch (error) {
    console.log({ error });
    res.status(500).json({ message: "failure", error });
  }
});

app.listen(expressPort, () => console.log(`served on port ${expressPort}`));