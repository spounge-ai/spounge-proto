import { create } from '@bufbuild/protobuf';
import {
  CreateWorkflowRequest,
  CreateWorkflowResponse,
  CreateWorkflowResponseSchema,
  GetWorkflowRequest,
  GetWorkflowResponse,
  GetWorkflowResponseSchema,
  UpdateWorkflowRequest,
  UpdateWorkflowResponse,
  UpdateWorkflowResponseSchema,
  DeleteWorkflowRequest,
  DeleteWorkflowResponse,
  DeleteWorkflowResponseSchema,
  ListWorkflowsRequest as BaseListWorkflowsRequest,
  ListWorkflowsResponse,
  ListWorkflowsResponseSchema,
  ListWorkflowVersionsRequest,
  ListWorkflowVersionsResponse,
  ListWorkflowVersionsResponseSchema,
} from '@spounge/proto-ts/workflow/v2';
import { PaginationParams, PaginationResultSchema } from '@spounge/proto-ts/common/v2';

interface ListWorkflowsRequest extends BaseListWorkflowsRequest {
  userId?: string;
  pagination?: PaginationParams;
}
import { MockDataGenerator } from '../utils/mock-data';
import { ValidationHelper } from '../utils/validation';
import { Logger } from '../utils/logger';

export class WorkflowService {
  async createWorkflow(req: CreateWorkflowRequest): Promise<CreateWorkflowResponse> {
    Logger.info('CreateWorkflow request received', { name: req.name });
    
    try {
      ValidationHelper.validateWorkflowName(req.name);

      const steps = req.steps && req.steps.length > 0 
        ? req.steps 
        : [MockDataGenerator.createMockStep('step1', 'Mock Step')];

      const mockWorkflow = MockDataGenerator.createMockWorkflow({
        name: req.name,
        description: req.description || 'Default description',
        steps
      });

      Logger.info('Mock workflow created', { id: mockWorkflow.id });
      return create(CreateWorkflowResponseSchema, { workflow: mockWorkflow });
    } catch (error) {
      Logger.error('Error creating workflow', error);
      throw error;
    }
  }

  async getWorkflow(req: GetWorkflowRequest): Promise<GetWorkflowResponse> {
    Logger.info('GetWorkflow request received', { workflowId: req.workflowId });
    
    try {
      ValidationHelper.validateWorkflowId(req.workflowId);

      const mockWorkflow = MockDataGenerator.createMockWorkflow({
        id: req.workflowId,
        name: 'Mock Workflow Name',
        description: 'This is a mock workflow for testing.',
        version: req.version || 1
      });

      Logger.info('Mock workflow retrieved', { id: mockWorkflow.id });
      return create(GetWorkflowResponseSchema, { workflow: mockWorkflow });
    } catch (error) {
      Logger.error('Error retrieving workflow', error);
      throw error;
    }
  }

  async updateWorkflow(req: UpdateWorkflowRequest): Promise<UpdateWorkflowResponse> {
    Logger.info('UpdateWorkflow request received', { workflowId: req.workflowId });
    
    try {
      ValidationHelper.validateUpdateRequest(req.workflowId, req.updateMask);

      const mockUpdatedWorkflow = MockDataGenerator.createMockWorkflow({
        id: req.workflowId,
        name: req.name || 'Updated Mock Workflow Name',
        description: req.description || 'Updated mock description.',
        version: 2,
        steps: req.steps || [MockDataGenerator.createMockStep('step1', 'Updated Mock Step')],
        createdAt: new Date(Date.now() - 3600000), // 1 hour ago
        updatedAt: new Date()
      });

      Logger.info('Mock workflow updated', { id: mockUpdatedWorkflow.id });
      return create(UpdateWorkflowResponseSchema, { workflow: mockUpdatedWorkflow });
    } catch (error) {
      Logger.error('Error updating workflow', error);
      throw error;
    }
  }

  async deleteWorkflow(req: DeleteWorkflowRequest): Promise<DeleteWorkflowResponse> {
    Logger.info('DeleteWorkflow request received', { workflowId: req.workflowId });
    
    try {
      ValidationHelper.validateWorkflowId(req.workflowId);

      Logger.info('Mock workflow deleted', { id: req.workflowId });
      return create(DeleteWorkflowResponseSchema, { 
        status: MockDataGenerator.createSuccessStatus('Workflow deleted successfully') 
      });
    } catch (error) {
      Logger.error('Error deleting workflow', error);
      throw error;
    }
  }

  async listWorkflows(req: ListWorkflowsRequest): Promise<ListWorkflowsResponse> {
    Logger.info('ListWorkflows request received', { userId: req.userId });
    
    try {
      // Validate pagination parameters if present
      ValidationHelper.validatePagination(req.pagination);

      const mockWorkflows = MockDataGenerator.createMockWorkflowBatch(10);
      const pagination = MockDataGenerator.createPaginationResult(
        req.pagination?.page || 1,
        req.pagination?.pageSize || 10,
        mockWorkflows.length
      );
      
      // Calculate offset and limit for pagination
      const startIndex = (pagination.page - 1) * pagination.pageSize;
      const endIndex = startIndex + pagination.pageSize;
      const paginatedWorkflows = mockWorkflows.slice(startIndex, endIndex);

      Logger.info('Mock workflows listed', { 
        count: paginatedWorkflows.length, 
        page: pagination.page, 
        pageSize: pagination.pageSize, 
        totalItems: pagination.totalItems 
      });

      return create(ListWorkflowsResponseSchema, {
        workflows: paginatedWorkflows,
        pagination: create(PaginationResultSchema, pagination)
      });
    } catch (error) {
      Logger.error('Error listing workflows', error);
      throw error;
    }
  }

  async listWorkflowVersions(req: ListWorkflowVersionsRequest): Promise<ListWorkflowVersionsResponse> {
    Logger.info('ListWorkflowVersions request received', { workflowId: req.workflowId });
    
    try {
      ValidationHelper.validateWorkflowId(req.workflowId);

      const mockVersions = [
        MockDataGenerator.createMockWorkflow({ 
          id: req.workflowId, 
          name: 'Workflow V1', 
          version: 1 
        }),
        MockDataGenerator.createMockWorkflow({ 
          id: req.workflowId, 
          name: 'Workflow V2', 
          version: 2 
        })
      ];

      Logger.info('Mock workflow versions listed', { 
        workflowId: req.workflowId, 
        count: mockVersions.length 
      });
      return create(ListWorkflowVersionsResponseSchema, { versions: mockVersions });
    } catch (error) {
      Logger.error('Error listing workflow versions', error);
      throw error;
    }
  }
}

