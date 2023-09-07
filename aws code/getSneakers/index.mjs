import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, ScanCommand } from "@aws-sdk/lib-dynamodb";
import { S3Client, GetObjectCommand, ListObjectsV2Command } from '@aws-sdk/client-s3';

const client = new DynamoDBClient();
const dynamodb = DynamoDBDocumentClient.from(client);

const s3Client = new S3Client({ region: 'us-east-1' });

export const handler = async(event) => {
    // get sneakers data from dynamodb
    try {
    const params = {
      TableName: "SneakersTerm",
    };

    const result = await dynamodb.send(new ScanCommand(params));
    
    const items = result.Items;
    
    for(const item of items) {
      const bucketName = 'term-project-5409';
      const folderName = item.name + "/";
      
      const params = {
        Bucket: bucketName,
        Prefix: folderName
      };
      const data = await s3Client.send(new ListObjectsV2Command(params));
      
      const imagesLinks = [];
      if (data.Contents) {
        for (const object of data.Contents) {
          if(object.Key !== folderName) {
            object.Key = object.Key.replaceAll(" ", "+");
            const url = `https://term-project-5409.s3.amazonaws.com/${object.Key}`;
            imagesLinks.push(url);
          }
        }
      }
      item.images = imagesLinks;
    }
    
    return {
      statusCode: 200,
      body: JSON.stringify(items),
      headers: {
        "Content-Type": "application/json",
      }
    };
  } catch (error) {
    console.error('Error fetching items from DynamoDB.', error);
    return {
      statusCode: 500,
      body: 'Error fetching items from DynamoDB',
    };
  }
};
