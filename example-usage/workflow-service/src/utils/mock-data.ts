
import { create } from '@bufbuild/protobuf';
import { TimestampSchema } from '@bufbuild/protobuf/wkt';
import { WorkflowConfigSchema, WorkflowStepSchema } from '@spounge/proto-ts/workflow/v2';
import { StatusSchema } from '@spounge/proto-ts/common/v2';
import type { MockWorkflowData } from '../types/workflow.types';

export class MockDataGenerator {
  static createTimestamp(date: Date = new Date()) {
    return create(TimestampSchema, { 
      seconds: BigInt(Math.floor(date.getTime() / 1000)) 
    });
  }

  static createMockStep(id: string, name: string, toolName: string = 'mockTool') {
    return create(WorkflowStepSchema, {
      id,
      name,
      toolName,
      parameters: {}
    });
  }

  private static mockWorkflowCounter = 1;

  static createMockWorkflow(data: Partial<MockWorkflowData>): any {
    const now = new Date();
    const createdAt = data.createdAt || now;
    const updatedAt = data.updatedAt || now;

    // Generate a deterministic ID if not provided
    const id = data.id || `mock-wf-${String(this.mockWorkflowCounter++).padStart(3, '0')}`;

    return create(WorkflowConfigSchema, {
      id,
      userId: data.userId || 'user-123',
      name: data.name || `Mock Workflow ${id}`,
      description: data.description || `A mock workflow for testing with ID ${id}`,
      version: data.version || 1,
      steps: data.steps || [this.createMockStep(`${id}-step1`, `Mock Step for ${id}`)],
      createdAt: this.createTimestamp(createdAt),
      updatedAt: this.createTimestamp(updatedAt)
    });
  }

  static createMockWorkflowBatch(count: number, overrides: Partial<MockWorkflowData> = {}): any[] {
    return Array.from({ length: count }, (_, index) => {
      const id = `mock-wf-${String(index + 1).padStart(3, '0')}`;
      return this.createMockWorkflow({
        ...overrides,
        id,
        name: overrides.name || `Workflow ${index + 1}`,
        description: overrides.description || `Test workflow number ${index + 1}`
      });
    });
  }

  static createSuccessStatus(message: string = 'OK') {
    return create(StatusSchema, { code: 0, message });
  }

  static createPaginationResult(page: number, pageSize: number, totalItems: number) {
    const totalPages = Math.ceil(totalItems / pageSize);
    const validatedPage = Math.min(Math.max(1, page), totalPages);
    const validatedPageSize = Math.min(Math.max(1, pageSize), 100);

    return {
      page: validatedPage,
      pageSize: validatedPageSize,
      totalItems,
      totalPages
    };
  }
}

// src/utils/validation.ts
import { ConnectError, Code } from '@connectrpc/connect';

export class ValidationHelper {
  static validateRequired(value: any, fieldName: string): void {
    if (!value) {
      throw new ConnectError(`${fieldName} is required.`, Code.InvalidArgument);
    }
  }

  static validateWorkflowId(workflowId: string): void {
    this.validateRequired(workflowId, 'Workflow ID');
  }

  static validateWorkflowName(name: string): void {
    this.validateRequired(name, 'Workflow name');
  }

  static validateUpdateRequest(workflowId: string, updateMask: any): void {
    this.validateRequired(workflowId, 'Workflow ID');
    this.validateRequired(updateMask, 'Update mask');
  }
}

// src/utils/logger.ts
export class Logger {
  static info(message: string, data?: any): void {
    console.log(`[INFO] ${message}`, data || '');
  }

  static error(message: string, error?: any): void {
    console.error(`[ERROR] ${message}`, error || '');
  }

  static debug(message: string, data?: any): void {
    if (process.env.NODE_ENV === 'development') {
      console.debug(`[DEBUG] ${message}`, data || '');
    }
  }
}
