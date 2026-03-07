---
name: nextjs-sse
description: >
  Next.js Server-Sent Events (SSE) for real-time streaming of data.
  Trigger: When building real-time features, streaming responses, or live data updates.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## What is SSE (Server-Sent Events)?

**SSE** is a protocol for pushing real-time data from server to client over HTTP. Use when:
- Server sends updates to client (notifications, live feeds)
- Client doesn't need to send data to server frequently
- You need automatic reconnection

**NOT for:**
- Bidirectional communication → use WebSocket
- Very high frequency updates → use WebSocket
- Real-time collaboration → use WebSocket

## Basic SSE Route (Next.js)

```typescript
// app/api/events/route.ts
import { NextRequest, NextResponse } from "next/server";

export async function GET(request: NextRequest) {
  // Validate client can accept SSE
  const headers = {
    "Content-Type": "text/event-stream",
    "Cache-Control": "no-cache",
    "Connection": "keep-alive",
  };

  // Create readable stream
  const stream = new ReadableStream({
    async start(controller) {
      // Send initial data
      controller.enqueue("data: Connection established\n\n");

      // Simulate sending data every second
      const interval = setInterval(() => {
        const data = new Date().toISOString();
        controller.enqueue(`data: ${JSON.stringify({ timestamp: data })}\n\n`);
      }, 1000);

      // Cleanup on close
      request.signal.addEventListener("abort", () => {
        clearInterval(interval);
        controller.close();
      });
    },
  });

  return new NextResponse(stream, { headers });
}
```

## Client-Side: EventSource API

```typescript
// ✅ Basic EventSource usage
useEffect(() => {
  const eventSource = new EventSource("/api/events");

  eventSource.onopen = () => {
    console.log("Connected to SSE");
  };

  eventSource.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log("Received:", data);
    setMessages(prev => [...prev, data]);
  };

  eventSource.onerror = (error) => {
    console.error("SSE error:", error);
    eventSource.close();
  };

  return () => eventSource.close();
}, []);

// ✅ Multiple event types
eventSource.addEventListener("notification", (event) => {
  const data = JSON.parse(event.data);
  setNotifications(prev => [...prev, data]);
});

eventSource.addEventListener("chat-message", (event) => {
  const message = JSON.parse(event.data);
  setMessages(prev => [...prev, message]);
});
```

## Streaming API Responses with SSE

```typescript
// ✅ Stream search results
// app/api/search/route.ts
export async function GET(request: NextRequest) {
  const query = request.nextUrl.searchParams.get("q") || "";

  const stream = new ReadableStream({
    async start(controller) {
      try {
        // Search database
        const results = await db.search(query);

        // Stream results one by one
        for (const result of results) {
          controller.enqueue(
            `data: ${JSON.stringify({ result })}\n\n`
          );
          // Small delay to simulate processing
          await new Promise(resolve => setTimeout(resolve, 100));
        }

        controller.enqueue("data: [DONE]\n\n");
        controller.close();
      } catch (error) {
        controller.error(error);
      }
    },
  });

  return new NextResponse(stream, {
    headers: {
      "Content-Type": "text/event-stream",
      "Cache-Control": "no-cache",
      "Connection": "keep-alive",
    },
  });
}

// Client
const response = await fetch(`/api/search?q=${query}`);
const reader = response.body.getReader();
const decoder = new TextDecoder();

while (true) {
  const { done, value } = await reader.read();
  if (done) break;

  const text = decoder.decode(value);
  const lines = text.split("\n");

  for (const line of lines) {
    if (line.startsWith("data: ")) {
      const data = line.slice(6);
      if (data === "[DONE]") return;
      
      const result = JSON.parse(data);
      console.log("Result:", result);
    }
  }
}
```

## Streaming AI Responses (Like ChatGPT)

```typescript
// ✅ Stream tokens from AI API
// app/api/ai/chat/route.ts
import { Anthropic } from "@anthropic-ai/sdk";

export async function POST(request: NextRequest) {
  const { message } = await request.json();

  const stream = new ReadableStream({
    async start(controller) {
      try {
        const client = new Anthropic();

        const response = await client.messages.create({
          model: "claude-3-5-sonnet-20241022",
          max_tokens: 1024,
          stream: true,
          messages: [{ role: "user", content: message }],
        });

        for await (const event of response) {
          if (event.type === "content_block_delta") {
            const delta = event.delta;
            if (delta.type === "text_delta") {
              // Stream token
              controller.enqueue(
                `data: ${JSON.stringify({ token: delta.text })}\n\n`
              );
            }
          }
        }

        controller.enqueue("data: [DONE]\n\n");
        controller.close();
      } catch (error) {
        controller.error(error);
      }
    },
  });

  return new NextResponse(stream, {
    headers: {
      "Content-Type": "text/event-stream",
      "Cache-Control": "no-cache",
      "Connection": "keep-alive",
    },
  });
}

// Client with React hook
function useAIStream(message: string) {
  const [response, setResponse] = useState("");
  const [loading, setLoading] = useState(false);

  const stream = useCallback(async () => {
    setLoading(true);
    setResponse("");

    try {
      const res = await fetch("/api/ai/chat", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message }),
      });

      const reader = res.body.getReader();
      const decoder = new TextDecoder();

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        const text = decoder.decode(value);
        const lines = text.split("\n");

        for (const line of lines) {
          if (line.startsWith("data: ")) {
            const data = line.slice(6);
            if (data === "[DONE]") return;

            const { token } = JSON.parse(data);
            setResponse(prev => prev + token);
          }
        }
      }
    } finally {
      setLoading(false);
    }
  }, [message]);

  return { response, loading, stream };
}
```

## Event Types & Formatting

```typescript
// ✅ Custom event types
// Server
controller.enqueue("event: notification\n");
controller.enqueue(`data: ${JSON.stringify({ title: "Alert" })}\n\n`);

controller.enqueue("event: chat-message\n");
controller.enqueue(`data: ${JSON.stringify({ user: "John", text: "Hi" })}\n\n`);

// Client
eventSource.addEventListener("notification", (event) => {
  console.log("Notification:", JSON.parse(event.data));
});

eventSource.addEventListener("chat-message", (event) => {
  console.log("Message:", JSON.parse(event.data));
});

// ✅ Include message ID for resuming
controller.enqueue("id: 1\n");
controller.enqueue("event: update\n");
controller.enqueue(`data: ${JSON.stringify({ count: 1 })}\n\n`);

// Client can resume from ID if connection drops
eventSource = new EventSource("/api/events?lastId=1");
```

## Heartbeat & Keep-Alive

```typescript
// ✅ Send heartbeat to keep connection alive
export async function GET(request: NextRequest) {
  const stream = new ReadableStream({
    async start(controller) {
      // Send heartbeat every 30 seconds
      const heartbeat = setInterval(() => {
        controller.enqueue(": heartbeat\n\n");
      }, 30000);

      // Actual data
      const interval = setInterval(() => {
        const data = { timestamp: new Date() };
        controller.enqueue(`data: ${JSON.stringify(data)}\n\n`);
      }, 5000);

      request.signal.addEventListener("abort", () => {
        clearInterval(heartbeat);
        clearInterval(interval);
        controller.close();
      });
    },
  });

  return new NextResponse(stream, {
    headers: {
      "Content-Type": "text/event-stream",
      "Cache-Control": "no-cache",
      "Connection": "keep-alive",
    },
  });
}
```

## Automatic Reconnection

```typescript
// ✅ EventSource auto-reconnects on failure
const eventSource = new EventSource("/api/events");

eventSource.onerror = (event) => {
  if (eventSource.readyState === EventSource.CLOSED) {
    console.log("Connection closed");
  } else {
    console.log("Reconnecting in 5 seconds...");
    // EventSource will retry automatically
    // Specify retry delay on server:
    // controller.enqueue("retry: 5000\n\n");
  }
};

// ✅ Manual reconnection control
function useSSE(url: string) {
  const [connected, setConnected] = useState(false);
  const sourceRef = useRef<EventSource | null>(null);

  const connect = useCallback(() => {
    const source = new EventSource(url);

    source.onopen = () => setConnected(true);
    source.onmessage = (e) => console.log(JSON.parse(e.data));
    source.onerror = () => {
      setConnected(false);
      // Reconnect after 3 seconds
      setTimeout(connect, 3000);
    };

    sourceRef.current = source;
  }, [url]);

  const disconnect = useCallback(() => {
    sourceRef.current?.close();
    setConnected(false);
  }, []);

  return { connected, connect, disconnect };
}
```

## Real-World Example: Notification System

```typescript
// ✅ Server: Stream notifications to user
// app/api/notifications/route.ts
import { auth } from "@/lib/auth";

export async function GET(request: NextRequest) {
  const session = await auth();
  if (!session) return new NextResponse("Unauthorized", { status: 401 });

  const stream = new ReadableStream({
    async start(controller) {
      // Get previous notifications
      const notifications = await db.notifications.findMany({
        where: { userId: session.user.id, read: false },
      });

      // Stream existing
      for (const notif of notifications) {
        controller.enqueue(
          `data: ${JSON.stringify(notif)}\n\n`
        );
      }

      // Subscribe to new
      const unsubscribe = subscribeToUserNotifications(
        session.user.id,
        (notification) => {
          controller.enqueue(
            `data: ${JSON.stringify(notification)}\n\n`
          );
        }
      );

      request.signal.addEventListener("abort", unsubscribe);
    },
  });

  return new NextResponse(stream, {
    headers: {
      "Content-Type": "text/event-stream",
      "Cache-Control": "no-cache",
    },
  });
}

// ✅ Client: React hook for notifications
function useNotifications() {
  const [notifications, setNotifications] = useState([]);

  useEffect(() => {
    const source = new EventSource("/api/notifications");

    source.onmessage = (event) => {
      const notification = JSON.parse(event.data);
      setNotifications(prev => [notification, ...prev]);

      // Toast notification
      toast.info(notification.message);
    };

    source.onerror = () => source.close();

    return () => source.close();
  }, []);

  return notifications;
}
```

## Performance & Scaling

```typescript
// ✅ Limit concurrent streams
const MAX_STREAMS = 1000;
let activeStreams = 0;

export async function GET(request: NextRequest) {
  if (activeStreams >= MAX_STREAMS) {
    return new NextResponse("Server at capacity", { status: 503 });
  }

  activeStreams++;

  const stream = new ReadableStream({
    async start(controller) {
      // ... stream implementation
      request.signal.addEventListener("abort", () => {
        activeStreams--;
        controller.close();
      });
    },
  });

  return new NextResponse(stream, { headers: { /* ... */ } });
}

// ✅ Use Redis for multi-server broadcasts
import { createClient } from "redis";

const redis = createClient();
await redis.connect();

// Subscribe server-wide
redis.subscribe("notifications", (message) => {
  // Broadcast to all connected clients via streams
  notificationBroadcaster.emit(message);
});
```

## Best Practices Checklist

- ✅ Use SSE for server-to-client streaming
- ✅ Include proper headers (Content-Type, Cache-Control)
- ✅ Handle client disconnection cleanly
- ✅ Send heartbeat to keep connection alive
- ✅ Use custom event types for different data
- ✅ Include message IDs for resuming
- ✅ Implement reconnection logic
- ✅ Limit concurrent streams on server
- ✅ Test with slow/unreliable connections
- ✅ Use compression for large payloads
- ✅ Document event structure

## Limitations & Alternatives

| Feature | SSE | WebSocket |
|---------|-----|-----------|
| Direction | Server→Client | Bidirectional |
| Automatic Reconnect | ✅ Yes | ❌ No |
| HTTP/HTTPS | ✅ Yes | ⚠️ Different protocol |
| Frequency | Low-Medium | High |
| Complexity | Simple | More complex |
| Bandwidth | Lower | Higher |

Choose **SSE** for one-way streaming (notifications, live feeds).
Choose **WebSocket** for bidirectional real-time (chat, games).

## Keywords
sse, server-sent-events, streaming, real-time, nextjs, eventsource, websocket-alternative
