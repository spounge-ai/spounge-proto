---
"@spounge/proto": major
---
 

# SpoungeAI Platform - New Release Overview

This release introduces significant new functionalities and API definitions, greatly expanding the capabilities of the SpoungeAI platform. We've added comprehensive services for authentication, user management, workflow automation, and enhanced core AI features.

## New Services & Features

### Authentication Gateway Service (`api/v1/auth_gateway_service.proto`)

* **Login**: User authentication with email/password login and token issuance.
* **Refresh Token**: Obtain new access tokens using refresh tokens.
* **Logout**: Invalidate user sessions.

### Auth Service (`auth/v1/auth_service.proto`)

* Core authentication logic with RPCs for `Login`, `RefreshToken`, and `Logout`.
* `AuthToken` message for managing access and refresh tokens, including expiration and session IDs.
* `TokenType` enum for standard bearer tokens.

### Dashboard Service (`api/v1/dashboard_service.proto`)

* **GetDashboard**: Consolidated view of user-specific data: user profile, recent workflows, recent executions, API keys, and managed secrets.

### IAM (`iam/v1/`)

* **API Key Management (`iam/v1/api_key.proto`)**

  * `APIKey`: Public API key info (ID, user ID, name, prefix, description, timestamps).
  * `APIKeyWithSecret`: Sensitive key value, returned only on creation.
* **Managed Secrets (`iam/v1/managed_secret.proto`)**

* `ManagedSecret`: Represents a securely stored secret, either a singular item or a **Spounge Key** (a collection of multiple secrets), with fields for ID, user ID, name, type, and timestamps.
* `ManagedSecretType`: Enum distinguishing secret types, including singular items and collections (Spounge Keys).


### LLM Service (`llm/v1/llm.proto`)

* **Generate Text**: RPC for generating text with various LLM providers and customizable parameters.
* **Generate Text Stream**: Streaming RPC for real-time text generation.
* **Generate Embedding**: Generate vector embeddings from text.
* `Provider` enum for LLM providers (OpenAI, Anthropic, Google).
* Defines `Message`, `Tool`, `ToolCall`, `GenerationParams`, and `TokenUsage` for comprehensive LLM interaction.

### User Gateway Service (`api/v1/user_gateway_service.proto`)

* **GetUserProfile**: API gateway endpoint to retrieve user profile info.
* **UpdateUserProfile**: API gateway endpoint to modify user profile details.

### User Service (`user/v1/user_service.proto`)

* Core RPCs for fetching and updating user profile (`GetUserProfile`, `UpdateUserProfile`).
* Managed Secret management RPCs: `AddManagedSecret`, `ListManagedSecrets`, `GetManagedSecret`, `DeleteManagedSecret`.
* `UserProfile` and `AccountSettings` messages for user data.

### Vector DB Service (`vector_db/v1/vector_db.proto`)

* **Upsert**: Add or update vectors in collections.
* **Query**: Similarity search within vector collections.
* Defines `Vector` and `QueryResult` messages.

### Workflow Gateway Service (`api/v1/workflow_gateway_service.proto`)

* API gateway endpoints: `CreateWorkflow`, `GetWorkflow`, `ListWorkflows`.
* Workflow execution endpoints: `StartExecution`, `GetExecution`.

### Workflow Execution Service (`workflow/v1/execution_service.proto`)

* RPCs: `StartExecution`, `GetExecution`, `ListExecutions`, `CancelExecution`.
* **StreamExecution**: Real-time workflow execution status updates.
* `WorkflowExecution` and `WorkflowExecutionUpdate` messages for lifecycle tracking.
* `ExecutionStatus` enum for workflow lifecycle states.

### Workflow Service (`workflow/v1/workflow_service.proto`)

* Full CRUD and listing operations for workflows: `CreateWorkflow`, `GetWorkflow`, `UpdateWorkflow`, `DeleteWorkflow`, `ListWorkflows`, `ListWorkflowVersions`.
* `WorkflowConfig` message to define workflow graphs, including `WorkflowStep` nodes with tool execution parameters and dependencies.


## Updated Common Types (`common/v1/common.proto`)

No new services introduced, but several existing types are now widely used across new services, including:

* `Status`
* `File`
* `PaginationParams`
* `PaginationResult`
* `EntityId`
* `Metadata`
 