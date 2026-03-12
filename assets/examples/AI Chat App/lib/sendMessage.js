// Chat query handler — receives the user message and returns the AI response.
// The Chat component calls this query automatically when the user sends a message.
// Access the user's message via additionalScope: {{ chat.lastUserMessage }}

const userMessage = {{ chatBox.lastUserMessage }};

// Call your AI API (OpenAI, Anthropic, etc.) via a REST query
const response = await sendToAI.trigger({
  additionalScope: {
    message: userMessage
  }
});

// Return the assistant's response text
// The Chat component displays this as the assistant's reply
return response.choices[0].message.content;
