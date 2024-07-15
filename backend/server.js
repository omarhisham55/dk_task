const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");
const dotenv = require("dotenv");

dotenv.config({ path: "../.env" });

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(cors());

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

app.get("/products", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM products");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
});

// Function to save a new user
const bcrypt = require("bcrypt");
const { v4: uuidv4 } = require("uuid");
async function saveUser(username, password) {
  try {
    const existingUser = await pool.query(
      "SELECT * FROM users WHERE username = $1",
      [username]
    );
    if (existingUser.rows.length > 0) {
      // Username already exists, return the existing user
      return existingUser.rows[0];
    }
    const id = uuidv4();
    const hashedPassword = await bcrypt.hash(password, 10);
    const query =
      "INSERT INTO users (id, username, password) VALUES ($1, $2, $3) RETURNING *";
    const values = [id, username, hashedPassword];
    const result = await pool.query(query, values);
    addDummyDataOnSave(result.rows[0].id);
    return result.rows[0]; // Return the inserted user
  } catch (error) {
    console.error("Error saving user:", error);
    throw error;
  }
}

async function addDummyDataOnSave(userId) {
  try {
    const id1 = uuidv4();
    const id2 = uuidv4();
    const userProductsQuery =
      "INSERT INTO user_products (id, user_id, product_id) VALUES ($1, $2, 1), ($3, $2, 2)";
    const result = await pool.query(userProductsQuery, [id1, userId, id2]);
    return result.rows[0];
  } catch (error) {
    console.error("Error saving user:", error);
    throw error;
  }
}

// Function to retrieve a user by user_id
async function getUser(userId) {
  try {
    const query = "SELECT * FROM users WHERE id = $1";
    const values = [userId];
    const result = await pool.query(query, values);
    return result.rows[0]; // Return the user if found
  } catch (error) {
    console.error("Error retrieving user:", error);
    throw error;
  }
}

// Endpoint to save a new user
app.post("/saveUser", async (req, res) => {
  console.log(req.body);
  try {
    const { username, password } = req.body;
    const newUser = await saveUser(username, password);
    res.json(newUser);
  } catch (err) {
    res.status(500).json({ error: "Failed to save user" });
  }
});

// Endpoint to retrieve a user by user_id
app.get("/getUser/:userId", async (req, res) => {
  try {
    const { userId } = req.params;
    const user = await getUser(userId);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    console.log(res.statusCode);
    console.log(user);
    res.json(user);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to retrieve user" });
  }
});

app.get("/user-products/:userId", async (req, res) => {
  try {
    const { userId } = req.params;
    const userProducts = await pool.query(
      "SELECT * FROM user_products WHERE user_id = $1",
      [userId]
    );
    res.json(userProducts.rows);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
