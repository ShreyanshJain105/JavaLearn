# Java Chat — AI-Powered JDK 25 Learning

**Java Chat** is a high-performance, full-stack RAG (Retrieval-Augmented Generation) application designed to provide precise, context-aware answers to Java development questions. It leverages the latest JDK documentation and professional learning resources to ensure accuracy and depth.

Developed with a focus on **Premium Aesthetics** and **Functional Clarity**.

---

## 🚀 Why RAG? (Retrieval-Augmented Generation)

Standard LLMs (like GPT-4 or Llama 3) have a "knowledge cutoff" and may hallucinate details about specific APIs or recent JDK releases. This project implements a **RAG Pipeline** to solve this:

1.  **Precision**: Instead of relying solely on the LLM's memory, the system retrieves relevant snippets from the official JDK 25 documentation and curated Java books.
2.  **Context-Awareness**: The LLM uses these retrieved documents as "ground truth" to answer queries, ensuring the response is technically accurate.
3.  **Citations**: Every answer includes direct citations to the sources used, allowing developers to verify the information.
4.  **Zero Hallucination**: By grounding the LLM in real documentation, we significantly reduce the risk of incorrect code snippets or outdated patterns.

---

## 🛠 Tech Stack

### Backend (The Brain)
- **Java 21/25**: Utilizing modern Java features like Virtual Threads and Records.
- **Spring Boot 3**: The foundation for our REST and Streaming APIs.
- **Spring WebFlux**: Enables non-blocking, reactive streaming for low-latency AI responses.
- **Qdrant Vector Database**: High-performance vector similarity search for document retrieval.
- **Groq & OpenAI SDKs**: Leverages `llama-3.3-70b` and `gpt-4o` for high-reasoning capabilities.
- **Spring AI (Inspiration)**: Custom implementation for precise control over the RAG pipeline.

### Frontend (The Experience)
- **Svelte 5**: The next generation of Svelte, using "Runes" for ultra-efficient state management.
- **Vite**: Lightning-fast build tool and development server.
- **TypeScript**: Ensures type safety across the entire UI layer.
- **Neo-Editorial Design**: A custom-built design system featuring:
  - **Glassmorphism**: Translucent, blurred surfaces for depth.
  - **Premium Motion**: Staggered entrance animations and elastic micro-interactions.
  - **Theming**: Integrated Dark and Light modes with persistent state.

---

## 🏗 Architecture

The system follows a modern decoupled architecture:

1.  **Ingestion**: Documentation is chunked, embedded into vectors, and stored in **Qdrant**.
2.  **Retrieval**: When a user asks a question, the backend generates an embedding for the query and finds the most relevant document chunks in Qdrant.
3.  **Generation**: The query + retrieved context is sent to the LLM (via Groq) to generate a grounded response.
4.  **Streaming**: The response is streamed to the frontend in real-time using **Server-Sent Events (SSE)** for a "Typewriter" effect (TTFB < 200ms).

---

## ✨ Features

- **Semantic Search**: Find answers by meaning, not just keywords.
- **Guided Learning**: Structured lessons on Java fundamentals (Variables, Streams, Threads).
- **Citations Panel**: Transparent sourcing for every AI response.
- **Premium UI**: Smooth animations, floating cards, and a refined "Ochre" design system.
- **Theme Toggle**: Seamless switching between Dark and Light "Paper" modes.

---

## 🛠 Getting Started

### Prerequisites
- Docker (for Qdrant)
- JDK 21 or 25
- Node.js (v18+)

### 1. Start Vector Store
```bash
docker run -p 6333:6333 -p 6334:6334 qdrant/qdrant
```

### 2. Configure Environment
Create a `.env` file in the root directory:
```env
OPENAI_API_KEY=your_groq_api_key
OPENAI_BASE_URL=https://api.groq.com/openai/v1
OPENAI_MODEL=llama-3.3-70b-versatile
```

### 3. Run Backend
```bash
./gradlew bootRun
```

### 4. Run Frontend
```bash
cd frontend
npm install
npm run dev
```

---

## 👨‍💻 Developed By

**Shreyansh Jain**

Driven by a passion for Java and the future of AI-integrated development.

---

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
