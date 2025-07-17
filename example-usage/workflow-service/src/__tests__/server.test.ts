import { describe, expect, test, beforeAll, afterAll } from '@jest/globals';
import { createClient } from "@connectrpc/connect";
import { createGrpcTransport } from "@connectrpc/connect-node";
import { WorkflowService } from '@spounge/proto-ts/workflow/v2';
import { WorkflowServer } from '../server';
import path from 'path';

describe('WorkflowServer', () => {
  let server: WorkflowServer;
  const testPort = 50051;
  const testCertPath = path.join(__dirname, '../certs/localhost.crt');
  const testKeyPath = path.join(__dirname, '../certs/localhost.key');

  beforeAll(async () => {
    server = new WorkflowServer({
      port: testPort,
      host: 'localhost',
      keyPath: testKeyPath,
      certPath: testCertPath,
      enableLogging: false
    });
    
    await server.start();
  });

  afterAll(async () => {
    if (server) {
      await server.stop();
    }
  });

  test('basic RPC connectivity - listWorkflows', async () => {
    const transport = createGrpcTransport({
      baseUrl: `https://localhost:${testPort}`,
      interceptors: [],
      jsonOptions: {
        ignoreUnknownFields: true
      }
    });

    const client = createClient(WorkflowService, transport);
    const response = await client.listWorkflows({});

    expect(response).toBeDefined();
    expect(response.workflows).toBeDefined();
    expect(Array.isArray(response.workflows)).toBe(true);
    expect(response.pagination).toBeDefined();
  });
});