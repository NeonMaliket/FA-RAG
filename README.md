# RAG UI – Flutter Interface for Retrieval-Augmented Generation Systems

## Description

A cross-platform Flutter application (desktop/mobile) designed to interact with Retrieval-Augmented Generation (RAG) systems.  
The application provides a complete user interface for managing vector databases, language models, and user data, enabling full RAG workflows via an intuitive UI.

---

## Features

### 1. Vector Database Selection
- Support for external vector stores: `FAISS`, `Pinecone`, `Weaviate`, etc.
- Ability to connect custom databases via form input (e.g., API key, URL, namespace).
- Visual indicator for the currently selected database.

### 2. Model Selection
- Choose from pre-integrated models (e.g., `OpenAI`, `Hugging Face`).
- Add custom models by specifying API endpoints or local paths.
- Optional: display model description and metadata.

### 3. Data Upload & Vectorization
- File upload support: `PDF`, `TXT`, etc.
- Manual text input.
- Drag-and-drop area for user convenience.
- Launch vectorization with status feedback (progress bar, document count).

### 4. Query Interface
- Text input for user queries.
- "Send" button to trigger embedding-based search.
- Result panel with generated response and source references (if available).
- Optional: filters and advanced query options.

### 5. System Settings
- Adjustable parameters (e.g., model temperature, embedding dimension).
- Theme switching: light/dark modes.
- Language settings (i18n).
- Persistent configuration with a “Save” button.

---

## UI Architecture

- **Screens**:  
  - `Database Selection`  
  - `Model Selection`  
  - `Data Upload`  
  - `Vectorization`  
  - `Query Execution`  
  - `Settings`

- **Navigation**:  
  - Desktop: Sidebar navigation  
  - Mobile: Bottom navigation bar

- **Design**:  
  - Responsive layout  
  - Material 3 components  
  - Light and dark theme support  
  - Accessibility-aware (contrast, labeling, readable fonts)

---

## Technical Stack

- **Framework**: Flutter  
- **Architecture**: Modular screen-based UI  
- **API**: Abstracted layer for model/database communication  
- **Validation**: Full form validation for all user input  
- **Localization**: i18n-ready  
- **Error Handling**: Structured user feedback for all error states

---

## Project Goal

This project provides a practical, modular interface layer for RAG-based systems.  
It is suitable for prototyping, testing, and deploying workflows involving vectorized data search and generation using LLMs and embedding models.

The app is intended for technical users — such as ML engineers, researchers, and developers — working with custom or third-party vector databases and language models.
