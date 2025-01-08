import {onRequest} from "firebase-functions/v2/https";
import * as functions from 'firebase-functions';
import * as logger from "firebase-functions/logger";
import OpenAI from "openai";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

const openai = new OpenAI({
  apiKey: functions.config().openai.apikey,
});

export const healthCheck = onRequest({
  region: "us-central1",
  cors: true,
  maxInstances: 10
}, (_request, response) => {
  logger.info("Health check");
  response.send("OK");
});

export const chatWithOpenAI = onRequest({
  region: "us-central1",
  cors: true,
  maxInstances: 10
}, async (request, response) => {
  logger.info("Chat with OpenAI");

  const prompt = request.body.prompt;

  if (!prompt) {
    response.status(400).send("Prompt is required");
    return;
  }

  try {
    const chatCompletion = await openai.chat.completions.create({
      model: "gpt-3.5-turbo",
      messages: [{role: "user", content: prompt}],
    });

    logger.info(chatCompletion.choices[0].message?.content);
    response.send(chatCompletion.choices[0].message?.content);
  } catch (error) {
    logger.error(error);
    response.status(500).send("Error calling OpenAI");
  }
});
