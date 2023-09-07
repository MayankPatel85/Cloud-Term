const { DynamoDBClient, GetItemCommand, UpdateItemCommand, PutItemCommand } = require("@aws-sdk/client-dynamodb");

const client = new DynamoDBClient({ region: "us-east-1" });

exports.handler = async (event, context) => {
    const resultList = event.body;

    for (const element of resultList) {
        const userId = element.userId;
        
        const getParams = {
            TableName: "ResultTerm",
            Key: {
                "userId": { "S": userId },
            }
        };

        try {
            const getCommand = new GetItemCommand(getParams);
            const getUser = await client.send(getCommand);
            console.log(getUser);
            if (getUser.Item) {
                const updateParams = {
                    TableName: "ResultTerm",
                    Key: {
                        "userId": { "S": userId }
                    },
                    UpdateExpression: "SET #results = list_append(#results, :new_result)",
                    ExpressionAttributeNames: {
                        "#results": "results"
                    },
                    ExpressionAttributeValues: {
                        ":new_result": { "L": [
                                {
                                    "M": {
                                        "id": { "S": element.id },
                                        "email": { "S": element.email },
                                        "size": { "S": element.size },
                                        "status": { "S": element.status },
                                        "sneakerId": { "S": element.sneakerId },
                                        "sneakerName": { "S": element.sneakerName },
                                        "releaseDate": { "S": element.releaseDate },
                                        "imageUrl": { "S": element.imageUrl }
                                    }
                                }
                            ]
                        }
                    }
                };
                await client.send(new UpdateItemCommand(updateParams));
            } else {
                console.log("else");
                console.log([element]);
                const putParams = {
                    TableName: "ResultTerm",
                    Item: {
                        "userId": { "S": userId },
                        "results": { "L": 
                            [
                                {
                                    "M": {
                                        "id": { "S": element.id },
                                        "email": { "S": element.email },
                                        "size": { "S": element.size },
                                        "status": { "S": element.status },
                                        "sneakerId": { "S": element.sneakerId },
                                        "sneakerName": { "S": element.sneakerName },
                                        "releaseDate": { "S": element.releaseDate },
                                        "imageUrl": { "S": element.imageUrl }
                                    }
                                }
                            ]
                        }
                    }
                };
                await client.send(new PutItemCommand(putParams));
            }
            const response = {
                statusCode: 200,
                body: JSON.stringify({ message: "Successfully added results." }),
                headers: {
                    'Content-Type': 'application/json'
                }
            };
            return response;
        } catch (err) {
            console.log("Error putting results", err);
            const response = {
                statusCode: 500,
                body: JSON.stringify({ message: "Error in puting results." }),
                headers: {
                    'Content-Type': 'application/json'
                }
            };
            return response;
        }
    }
};