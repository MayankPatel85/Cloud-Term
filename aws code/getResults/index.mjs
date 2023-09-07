import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, GetCommand } from "@aws-sdk/lib-dynamodb";


const client = new DynamoDBClient({ region: "us-east-1" });
const docClient = DynamoDBDocumentClient.from(client);

export const handler = async (event, context) => {
    
    const currentUserId = event.pathParameters.userId;

    const params = {
        TableName: "ResultTerm",
        Key: {
            userId: currentUserId
        },
    };

    try {
        const userResults = await docClient.send(new GetCommand(params));
        
        if(!userResults.Item) {
            const response = {
                statusCode: 200,
                body: JSON.stringify([]),
                headers: {
                    'Content-Type': 'application/json'
                }
            };
            return response;
        } else {
            const response = {
                statusCode: 200,
                body: JSON.stringify(userResults.Item),
                headers: {
                    'Content-Type': 'application/json'
                }
            };
            return response;   
        }
    } catch (err) {
        console.log("Error getting results", err);
            const response = {
                statusCode: 500,
                body: JSON.stringify({ message: "Error in getting results." }),
                headers: {
                    'Content-Type': 'application/json'
                }
            };
        return response;
    }
}