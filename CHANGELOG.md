# @spounge/proto

## 2.0.2

### Patch Changes

- [#23](https://github.com/spounge-ai/spounge-proto/pull/23) [`00f0f1d`](https://github.com/spounge-ai/spounge-proto/commit/00f0f1d454c90f6d53564f52d848f734cdbc8ace) Thanks [@Evantopian](https://github.com/Evantopian)! - [Hotfix] - Dependency Check

## 2.0.1

### Patch Changes

- [Go Module] - Versioning update for semantic parsers

## 2.0.0

### Major Changes

- [#20](https://github.com/spounge-ai/spounge-proto/pull/20) [`ba9ea49`](https://github.com/spounge-ai/spounge-proto/commit/ba9ea4930866c666e54a655f703bf1de5ff73ab7) Thanks [@Evantopian](https://github.com/Evantopian)! - # SpoungeAI Platform - New Release Overview

  This release introduces significant new functionalities and API definitions, greatly expanding the capabilities of the SpoungeAI platform. We've added comprehensive services for authentication, user management, workflow automation, and enhanced core AI features.

  ## New Services & Features

  ### Authentication Gateway Service (`api/v1/auth_gateway_service.proto`)

  - **Login**: User authentication with email/password login and token issuance.
  - **Refresh Token**: Obtain new access tokens using refresh tokens.
  - **Logout**: Invalidate user sessions.

  ### Auth Service (`auth/v1/auth_service.proto`)

  - Core authentication logic with RPCs for `Login`, `RefreshToken`, and `Logout`.
  - `AuthToken` message for managing access and refresh tokens, including expiration and session IDs.
  - `TokenType` enum for standard bearer tokens.

  ### Dashboard Service (`api/v1/dashboard_service.proto`)

  - **GetDashboard**: Consolidated view of user-specific data: user profile, recent workflows, recent executions, API keys, and managed secrets.

  ### IAM (`iam/v1/`)

  - **API Key Management (`iam/v1/api_key.proto`)**

    - `APIKey`: Public API key info (ID, user ID, name, prefix, description, timestamps).
    - `APIKeyWithSecret`: Sensitive key value, returned only on creation.

  - **Managed Secrets (`iam/v1/managed_secret.proto`)**

  - `ManagedSecret`: Represents a securely stored secret, either a singular item or a **Spounge Key** (a collection of multiple secrets), with fields for ID, user ID, name, type, and timestamps.
  - `ManagedSecretType`: Enum distinguishing secret types, including singular items and collections (Spounge Keys).

  ### LLM Service (`llm/v1/llm.proto`)

  - **Generate Text**: RPC for generating text with various LLM providers and customizable parameters.
  - **Generate Text Stream**: Streaming RPC for real-time text generation.
  - **Generate Embedding**: Generate vector embeddings from text.
  - `Provider` enum for LLM providers (OpenAI, Anthropic, Google).
  - Defines `Message`, `Tool`, `ToolCall`, `GenerationParams`, and `TokenUsage` for comprehensive LLM interaction.

  ### User Gateway Service (`api/v1/user_gateway_service.proto`)

  - **GetUserProfile**: API gateway endpoint to retrieve user profile info.
  - **UpdateUserProfile**: API gateway endpoint to modify user profile details.

  ### User Service (`user/v1/user_service.proto`)

  - Core RPCs for fetching and updating user profile (`GetUserProfile`, `UpdateUserProfile`).
  - Managed Secret management RPCs: `AddManagedSecret`, `ListManagedSecrets`, `GetManagedSecret`, `DeleteManagedSecret`.
  - `UserProfile` and `AccountSettings` messages for user data.

  ### Vector DB Service (`vector_db/v1/vector_db.proto`)

  - **Upsert**: Add or update vectors in collections.
  - **Query**: Similarity search within vector collections.
  - Defines `Vector` and `QueryResult` messages.

  ### Workflow Gateway Service (`api/v1/workflow_gateway_service.proto`)

  - API gateway endpoints: `CreateWorkflow`, `GetWorkflow`, `ListWorkflows`.
  - Workflow execution endpoints: `StartExecution`, `GetExecution`.

  ### Workflow Execution Service (`workflow/v1/execution_service.proto`)

  - RPCs: `StartExecution`, `GetExecution`, `ListExecutions`, `CancelExecution`.
  - **StreamExecution**: Real-time workflow execution status updates.
  - `WorkflowExecution` and `WorkflowExecutionUpdate` messages for lifecycle tracking.
  - `ExecutionStatus` enum for workflow lifecycle states.

  ### Workflow Service (`workflow/v1/workflow_service.proto`)

  - Full CRUD and listing operations for workflows: `CreateWorkflow`, `GetWorkflow`, `UpdateWorkflow`, `DeleteWorkflow`, `ListWorkflows`, `ListWorkflowVersions`.
  - `WorkflowConfig` message to define workflow graphs, including `WorkflowStep` nodes with tool execution parameters and dependencies.

  ## Updated Common Types (`common/v1/common.proto`)

  No new services introduced, but several existing types are now widely used across new services, including:

  - `Status`
  - `File`
  - `PaginationParams`
  - `PaginationResult`
  - `EntityId`
  - `Metadata`

### Minor Changes

- [#17](https://github.com/spounge-ai/spounge-proto/pull/17) [`ba9a62c`](https://github.com/spounge-ai/spounge-proto/commit/ba9a62c5ab8f7dd129f44e603a43cbbdc3f18705) Thanks [@Evantopian](https://github.com/Evantopian)! - [Repo] - Protoc go package dir change

### Patch Changes

- [`31d984c`](https://github.com/spounge-ai/spounge-proto/commit/31d984cbcd1ee94e19f1a75dd4fa348e665a9c8a) Thanks [@Evantopian](https://github.com/Evantopian)! - [Go Module] - Go Release Trigger

- [#15](https://github.com/spounge-ai/spounge-proto/pull/15) [`f318c91`](https://github.com/spounge-ai/spounge-proto/commit/f318c91b5acdb241f9bdd2dc005d40d57145026b) Thanks [@Evantopian](https://github.com/Evantopian)! - No function change

- [`ab930c4`](https://github.com/spounge-ai/spounge-proto/commit/ab930c47b9fe8bb8ca5f9c356e6765573d459755) Thanks [@Evantopian](https://github.com/Evantopian)! - [Hotfix] - Changelog update resolution

- [`f3820b4`](https://github.com/spounge-ai/spounge-proto/commit/f3820b4551c5b9170fced901a216c941253bf2bf) Thanks [@Evantopian](https://github.com/Evantopian)! - [Go Module] - Go module export change due to repo name change

## 1.0.6

### Patch Changes

- [`ed1c6ac`](https://github.com/SpoungeAI/spounge-proto/commit/ed1c6ac24a0339fd95ae26f49244bfe847cb0879) Thanks [@Evantopian](https://github.com/Evantopian)! - for git changesets

## 1.0.5

### Patch Changes

- [`b0dd55d`](https://github.com/SpoungeAI/spounge-proto/commit/b0dd55dd9bae6382e0393adcdee492ea698d712c) Thanks [@Evantopian](https://github.com/Evantopian)! - go tagging for pulling in module

- [#11](https://github.com/SpoungeAI/spounge-proto/pull/11) [`19dd316`](https://github.com/SpoungeAI/spounge-proto/commit/19dd3168871380c6b8af96b4f90e3baf0ed78131) Thanks [@Evantopian](https://github.com/Evantopian)! - [No Functionality Change] - Updated CI to take in docker image for speedup

- [#13](https://github.com/SpoungeAI/spounge-proto/pull/13) [`41cd914`](https://github.com/SpoungeAI/spounge-proto/commit/41cd914859a53255a68b764dcc9dfff92b89fd4a) Thanks [@Evantopian](https://github.com/Evantopian)! - [No Functionality Change] - Add tests scripts to be forwarded to service specific repos, README update.

## 1.0.4

### Patch Changes

- [`fe8d193`](https://github.com/SpoungeAI/spounge-proto/commit/fe8d1935245e00bb11bd1deed1cebd545cfed662) Thanks [@Evantopian](https://github.com/Evantopian)! - tagging @spounge/proto-ts versions for github

## 1.0.3

### Patch Changes

- [`2e80ad5`](https://github.com/SpoungeAI/spounge-proto/commit/2e80ad560fd7837544d3f548478e6e3ac18cc6b4) Thanks [@Evantopian](https://github.com/Evantopian)! - implementing checks for CI, irrelevant to package functionality"

## 1.0.2

### Patch Changes

- [#7](https://github.com/SpoungeAI/spounge-proto/pull/7) [`4f4ce99`](https://github.com/SpoungeAI/spounge-proto/commit/4f4ce9910cbca3bee115d60223cb456371bb0ba0) Thanks [@Evantopian](https://github.com/Evantopian)! - changeset init

- [#7](https://github.com/SpoungeAI/spounge-proto/pull/7) [`4f4ce99`](https://github.com/SpoungeAI/spounge-proto/commit/4f4ce9910cbca3bee115d60223cb456371bb0ba0) Thanks [@Evantopian](https://github.com/Evantopian)! - reconfiguration
