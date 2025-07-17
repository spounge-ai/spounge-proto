import { ConnectError, Code } from '@connectrpc/connect';
import { FieldMask } from '@bufbuild/protobuf/wkt';
import { PaginationParams } from '@spounge/proto-ts/common/v2';

export class ValidationHelper {
  static validateRequired<T>(value: T | undefined | null, fieldName: string): asserts value is NonNullable<T> {
    if (value === undefined || value === null || value === '') {
      throw new ConnectError(`${fieldName} is required.`, Code.InvalidArgument);
    }
  }

  static validateString(value: string | undefined, fieldName: string, options: { minLength?: number; maxLength?: number } = {}): void {
    if (value !== undefined) {
      if (options.minLength !== undefined && value.length < options.minLength) {
        throw new ConnectError(
          `${fieldName} must be at least ${options.minLength} characters long.`,
          Code.InvalidArgument
        );
      }
      if (options.maxLength !== undefined && value.length > options.maxLength) {
        throw new ConnectError(
          `${fieldName} cannot exceed ${options.maxLength} characters.`,
          Code.InvalidArgument
        );
      }
    }
  }

  static validateWorkflowId(workflowId: string | undefined): void {
    this.validateRequired(workflowId, 'Workflow ID');
    this.validateString(workflowId, 'Workflow ID', { minLength: 1, maxLength: 100 });
  }

  static validateWorkflowName(name: string | undefined): void {
    this.validateRequired(name, 'Workflow name');
    this.validateString(name, 'Workflow name', { minLength: 1, maxLength: 100 });
  }

  static validateUpdateRequest(workflowId: string | undefined, updateMask: FieldMask | undefined): void {
    this.validateRequired(workflowId, 'Workflow ID');
    this.validateRequired(updateMask, 'Update mask');
    
    // Validate that update_mask only contains allowed fields
    const allowedFields = ['name', 'description', 'steps'];
    updateMask.paths.forEach(path => {
      if (!allowedFields.includes(path)) {
        throw new ConnectError(
          `Invalid update_mask field: ${path}. Allowed fields are: ${allowedFields.join(', ')}`,
          Code.InvalidArgument
        );
      }
    });
  }

  static validatePagination(params: PaginationParams | undefined): void {
    if (params) {
      if (params.page !== undefined && params.page < 1) {
        throw new ConnectError('Page number must be greater than 0.', Code.InvalidArgument);
      }
      if (params.pageSize !== undefined && (params.pageSize < 1 || params.pageSize > 100)) {
        throw new ConnectError('Page size must be between 1 and 100.', Code.InvalidArgument);
      }
    }
  }
}