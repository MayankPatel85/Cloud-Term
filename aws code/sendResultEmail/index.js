const { SNSClient, PublishCommand } = require("@aws-sdk/client-sns");

const client = new SNSClient({ region: "us-east-1" });

exports.handler = async (event, context) => {
    const topicArn = process.env.TOPIC_ARN;
    
    const input = {
        TopicArn: topicArn,
        Message: "Draw results are out. Check the draw result now!"
    }

    try {
        await client.send(new PublishCommand(input));
        const response = {
            statusCode: 200,
            body: "Email sent!",
            headers: {
                'Content-Type': 'application/json'
            }
        };
        return response;
    } catch (err) {
        console.log("Error sending email", err);
        const response = {
            statusCode: 200,
            body: "Error sending email.",
            headers: {
                'Content-Type': 'application/json'
            }
        };
        return response;
    }
}