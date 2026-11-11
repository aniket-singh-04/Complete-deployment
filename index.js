import app from "./app.js";

const PORT = process.env.PORT;

// Start Server
app.listen(PORT, () => {
    console.log(`Server is running at port ${PORT}`);
});
