const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");

const client = new DynamoDBClient({ region: "us-east-1" });

exports.handler = async (event, context) => {
    const body = JSON.parse(event.body);
    
    console.log(body);

    const entryParam = {
        TableName: "EntriesTerm",
        Item: {
            id: { S: body.id },
            userId: { S: body.userId },
            email: { S: body.email },
            releaseDate: { S: body.releaseDate },
            size: { S: body.size },
            sneakerId: {S: body.sneakerId },
            sneakerName: { S: body.sneakerName },
            imageUrl: { S: body.imageUrl }
        }
    };

    try {
        await client.send(new PutItemCommand(entryParam));
        const response = {
            statusCode: 200,
            body: JSON.stringify({ message: "Successfully added entry." }),
            headers: {
                "Content-Type": "application/json"
            }
        };
        return response;
    }catch (err) {
        console.log("Error in adding entry: ", err);
        const response = {
            statusCode: 500,
            body: JSON.stringify({ message: "Error in adding entry." }),
            headers: {
                "Content-Type": "application/json"
            }
        };
        return response;
    }

}