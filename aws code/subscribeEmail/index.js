const { SNSClient, SubscribeCommand } = require("@aws-sdk/client-sns");

const client = new SNSClient({ region: "us-east-1" });

exports.handler = async (event, context) => {
    
    const topicArn = process.env.TOPIC_ARN;

    const body = JSON.parse(event.body);
    
    const email = body.email;

    const subscribeParams = {
        TopicArn: topicArn,
        Protocol: "email",
        Endpoint: email
    };
  
    try {
        await client.send(new SubscribeCommand(subscribeParams));
        const response = {
            statusCode: 200,
            body: "Successfully subscribed.",
            headers: {
                'Content-Type': 'application/json'
            }
        };
        return response;
    } catch (err) {
        console.log("Error creating subscription: ", err);
        const response = {
            statusCode: 500,
            body: "Error creating subscription.",
            headers: {
                'Content-Type': 'application/json'
            }
        };
        return response;
    }
}