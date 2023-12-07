/// handler.js
exports.hello = async (event) => {
    // Your Lambda function logic here
    return {
        statusCode: 200,
        body: JSON.stringify('Hello, World!'),
    };
};

