const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");

const client = new DynamoDBClient({ region: "us-east-1" });

exports.handler = async (event, context) => {
    const currentDate = new Date();
    let year = currentDate.getFullYear();
    let month = (1 + currentDate.getMonth()).toString().padStart(2, '0');
    let day = currentDate.getDate().toString().padStart(2, '0');
    
    const releaseDate = month + '-' + day + '-' + year;
    
    console.log(releaseDate);

    const entriesParamas = {
        TableName: "EntriesTerm",
        FilterExpression: "#dateAttribute = :dateValue",
        ExpressionAttributeNames: {
            "#dateAttribute": "releaseDate"
        },
        ExpressionAttributeValues: {
            ":dateValue": { S: releaseDate }
        }
    };

    const stockParams = {
        TableName: "StockTerm",
        FilterExpression: "releaseDate = :releaseDateValue",
        ExpressionAttributeValues: {
            ":releaseDateValue": { S: releaseDate }
        }
    };

    /**
     * author: Bergi
     * https://stackoverflow.com/questions/19269545/how-to-get-a-number-of-random-elements-from-an-array
     * @param {*} arr 
     * @param {*} n 
     */
    function getRandom(arr, n) {
        var result = new Array(n),
            len = arr.length,
            taken = new Array(len);
        if (n > len)
            throw new RangeError("getRandom: more elements taken than available");
        while (n--) {
            var x = Math.floor(Math.random() * len);
            result[n] = arr[x in taken ? taken[x] : x];
            taken[x] = --len in taken ? taken[len] : len;
        }
        arr.forEach((element) => {
            element.id = element.id.S;
            element.email = element.email.S;
            element.releaseDate = element.releaseDate.S;
            element.userId = element.userId.S;
            element.size = element.size.N;
            element.sneakerId = element.sneakerId.S;
            element.sneakerName = element.sneakerName.S;
            element.imageUrl = element.imageUrl.S;
            if(element in result) {
                element.status = "W";
            } else {
                element.status = "L";
            }
        });
    }

    try {
        const entriesCommand = new ScanCommand(entriesParamas);
        const entriesData = await client.send(entriesCommand);
        const entriesList = entriesData.Items;
        
        console.log(entriesList);

        const stockCommand = new ScanCommand(stockParams);
        const stockData = await client.send(stockCommand);
        const stockList = stockData.Items;
        
        console.log(stockList);

        const listWithStatus = [];

        stockList.forEach((stockItem) => {
            stockItem.stockInfo.L.forEach((stockInfo) => {
                const entriesBySize = entriesList.filter(entry => entry.size.S === stockInfo.M.size.S);
                var currentStock = stockInfo.M.stock.N;
                if(currentStock !== 0) {
                    if(entriesBySize.length > currentStock) {
                        getRandom(entriesBySize, currentStock);
                        listWithStatus.push(...entriesBySize);
                    } else {
                        entriesBySize.forEach((entry) => {
                            entry.id = entry.id.S;
                            entry.email = entry.email.S;
                            entry.releaseDate = entry.releaseDate.S;
                            entry.userId = entry.userId.S;
                            entry.size = entry.size.S;
                            entry.sneakerId = entry.sneakerId.S;
                            entry.sneakerName = entry.sneakerName.S;
                            entry.imageUrl = entry.imageUrl.S;
                            entry.status = "W";
                        });
                        listWithStatus.push(...entriesBySize);
                    }
                }
            });
        });

        const response = {
            statusCode: 200,
            body: listWithStatus,
            headers: {
                "Content-Type": "application/json"
            }
        };
        return response;
    } catch (err) {
        console.log("Error getting winners", err);
        const response = {
            statusCode: 500,
            body: { message: "Error getting winners" },
            headers: {
                "Content-Type": "application/json"
            }
        };
        return response;
    }
}