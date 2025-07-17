export interface WorkflowServiceConfig {
  port: number;
  host: string;
  corsOrigins?: string[];
  enableLogging?: boolean;

  keyPath: string;
  certPath: string;
}

export interface MockWorkflowData {
  id: string;
  userId: string;
  name: string;
  description?: string;
  version: number;
  steps: any[];
  createdAt: Date;
  updatedAt: Date;
}
