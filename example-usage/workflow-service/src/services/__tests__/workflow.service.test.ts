import { WorkflowService } from '../workflow.service';
import { create } from '@bufbuild/protobuf';
import { FieldMaskSchema } from '@bufbuild/protobuf/wkt';
import {
  CreateWorkflowRequestSchema,
  GetWorkflowRequestSchema,
  UpdateWorkflowRequestSchema,
  DeleteWorkflowRequestSchema,
  ListWorkflowsRequestSchema,
  ListWorkflowVersionsRequestSchema,
} from '@spounge/proto-ts/workflow/v2';
import { ConnectError, Code } from '@connectrpc/connect'; 

describe('WorkflowService', () => {
  let service: WorkflowService;

  beforeEach(() => {
    service = new WorkflowService();
  });

  describe('createWorkflow', () => {
    it('should create a workflow successfully', async () => {
      const request = create(CreateWorkflowRequestSchema, {
        name: 'Test Workflow',
        description: 'A test workflow'
      });

      const response = await service.createWorkflow(request);

      expect(response.workflow).toBeDefined();
      expect(response.workflow!.name).toBe('Test Workflow');
      expect(response.workflow!.description).toBe('A test workflow');
      expect(response.workflow!.id).toBeDefined();
    });

    it('should throw error when name is missing', async () => {
      const request = create(CreateWorkflowRequestSchema, {
        description: 'A test workflow'
      });

      await expect(service.createWorkflow(request)).rejects.toThrow(
        new ConnectError('Workflow name is required.', Code.InvalidArgument)
      );
    });

    it('should create default steps when none provided', async () => {
      const request = create(CreateWorkflowRequestSchema, {
        name: 'Test Workflow'
      });

      const response = await service.createWorkflow(request);

      expect(response.workflow!.steps).toHaveLength(1);
      expect(response.workflow!.steps[0].name).toBe('Mock Step');
    });
  });

  describe('getWorkflow', () => {
    it('should retrieve a workflow successfully', async () => {
      const request = create(GetWorkflowRequestSchema, {
        workflowId: 'test-workflow-id'
      });

      const response = await service.getWorkflow(request);

      expect(response.workflow).toBeDefined();
      expect(response.workflow!.id).toBe('test-workflow-id');
      expect(response.workflow!.name).toBe('Mock Workflow Name');
    });

    it('should throw error when workflowId is missing', async () => {
      const request = create(GetWorkflowRequestSchema, {});

      await expect(service.getWorkflow(request)).rejects.toThrow(
        new ConnectError('Workflow ID is required.', Code.InvalidArgument)
      );
    });

    it('should use provided version', async () => {
      const request = create(GetWorkflowRequestSchema, {
        workflowId: 'test-workflow-id',
        version: 5
      });

      const response = await service.getWorkflow(request);

      expect(response.workflow!.version).toBe(5);
    });
  });

  describe('updateWorkflow', () => {
    it('should update a workflow successfully', async () => {
      const request = create(UpdateWorkflowRequestSchema, {
        workflowId: 'test-workflow-id',
        name: 'Updated Workflow',
        updateMask: create(FieldMaskSchema, { paths: ['name'] })
      });

      const response = await service.updateWorkflow(request);

      expect(response.workflow).toBeDefined();
      expect(response.workflow!.name).toBe('Updated Workflow');
      expect(response.workflow!.version).toBe(2);
    });

    it('should throw error when workflowId is missing', async () => {
      const request = create(UpdateWorkflowRequestSchema, {
        name: 'Updated Workflow',
        updateMask: create(FieldMaskSchema, { paths: ['name'] })
      });

      await expect(service.updateWorkflow(request)).rejects.toThrow(
        new ConnectError('Workflow ID is required.', Code.InvalidArgument)
      );
    });

    it('should throw error when updateMask is missing', async () => {
      const request = create(UpdateWorkflowRequestSchema, {
        workflowId: 'test-workflow-id',
        name: 'Updated Workflow'
      });

      await expect(service.updateWorkflow(request)).rejects.toThrow(
        new ConnectError('Update mask is required.', Code.InvalidArgument)
      );
    });
  });

  describe('deleteWorkflow', () => {
    it('should delete a workflow successfully', async () => {
      const request = create(DeleteWorkflowRequestSchema, {
        workflowId: 'test-workflow-id'
      });

      const response = await service.deleteWorkflow(request);

      expect(response.status).toBeDefined();
      expect(response.status!.code).toBe(0);
    });

    it('should throw error when workflowId is missing', async () => {
      const request = create(DeleteWorkflowRequestSchema, {});

      await expect(service.deleteWorkflow(request)).rejects.toThrow(
        new ConnectError('Workflow ID is required.', Code.InvalidArgument)
      );
    });
  });

  describe('listWorkflows', () => {
    it('should list workflows successfully', async () => {
      const request = create(ListWorkflowsRequestSchema, {});

      const response = await service.listWorkflows(request);

      expect(response.workflows).toHaveLength(2);
      expect(response.pagination).toBeDefined();
      expect(response.pagination!.totalItems).toBe(2);
    });

    it('should handle pagination parameters', async () => {
      const request = create(ListWorkflowsRequestSchema, {
        pagination: {
          page: 2,
          pageSize: 5
        }
      });

      const response = await service.listWorkflows(request);

      expect(response.pagination!.page).toBe(2);
      expect(response.pagination!.pageSize).toBe(5);
    });
  });

  describe('listWorkflowVersions', () => {
    it('should list workflow versions successfully', async () => {
      const request = create(ListWorkflowVersionsRequestSchema, {
        workflowId: 'test-workflow-id'
      });

      const response = await service.listWorkflowVersions(request);

      expect(response.versions).toHaveLength(2);
      expect(response.versions[0].version).toBe(1);
      expect(response.versions[1].version).toBe(2);
    });

    it('should throw error when workflowId is missing', async () => {
      const request = create(ListWorkflowVersionsRequestSchema, {});

      await expect(service.listWorkflowVersions(request)).rejects.toThrow(
        new ConnectError('Workflow ID is required.', Code.InvalidArgument)
      );
    });
  });
});