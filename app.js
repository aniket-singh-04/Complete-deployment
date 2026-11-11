import express from "express";

const app = express();

// Route 1: Server Information
app.get("/", (req, res) => {
    return res.status(200).json({
        success: true,
        message: "Welcome to the Express Server",
        server: "Express.js",
        port: process.env.PORT,
        environment: process.env.NODE_ENV
    });
});

// Route 2: Health Check
app.get("/health", (req, res) => {
    return res.status(200).json({
        success: true,
        status: "OK",
        message: "Server is healthy",
        uptime: process.uptime()
    });
});

export default app;
