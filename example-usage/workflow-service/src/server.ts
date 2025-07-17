import express from 'express';
import http2 from 'http2'; 
import fs from 'fs'; 
import cors from 'cors';  
import { expressConnectMiddleware } from '@connectrpc/connect-express';
import { WorkflowService as WorkflowServiceDefinition } from '@spounge/proto-ts/workflow/v2';
import { WorkflowService } from './services/workflow.service';
import { Logger } from './utils/logger';
import type { WorkflowServiceConfig } from './types/workflow.types';

 
export class WorkflowServer {
  private app: express.Application;
  private server: http2.Http2SecureServer; 
  private workflowService: WorkflowService;
  private config: WorkflowServiceConfig;

  constructor(config: Partial<WorkflowServiceConfig> & { keyPath: string; certPath: string }) {
    this.config = {
      port: config.port || parseInt(process.env.PORT || '8080'),
      host: config.host || 'localhost',
      corsOrigins: config.corsOrigins || ['*'],
      enableLogging: config.enableLogging ?? true,
      ...config
    };

    this.app = express();
    this.workflowService = new WorkflowService();
    this.setupMiddleware();
    this.setupRoutes();
    
    const options = {
      key: fs.readFileSync(this.config.keyPath),
      cert: fs.readFileSync(this.config.certPath),
      allowHTTP1: false  
    };
    this.server = http2.createSecureServer(options, (req, res) => this.app(req as any, res as any));
  }

private setupMiddleware(): void {

    if (this.config.enableLogging) {
      this.app.use((req, _res, next) => {
        Logger.info(`${req.method} ${req.path}`, {
          headers: req.headers,
          body: req.body
        });
        next();
      });
    }
  }

  private setupRoutes(): void {
    // Health check endpoint
    this.app.get('/health', (_req, res) => {
      res.json({
         status: 'healthy',
         timestamp: new Date().toISOString(),
        service: 'workflow-service'
       });
    });

    // CORS middleware - Fixed: use proper import
    if (this.config.corsOrigins) {
      this.app.use(cors({
        origin: this.config.corsOrigins,
        methods: ['GET', 'POST', 'PUT', 'DELETE'],
        allowedHeaders: ['Content-Type', 'Authorization', 'Connect-Protocol-Version'],
        exposedHeaders: ['Connect-Protocol-Version'],
      }));
    }

    // Connect-ES middleware
    this.app.use(expressConnectMiddleware({
      routes: (router) => {
        router.service(WorkflowServiceDefinition, this.workflowService);
      }
    }));
  }

  public start(): Promise<void> {
    return new Promise((resolve) => {
      this.server.listen(this.config.port, this.config.host, () => {
        Logger.info(`Secure Connect-ES WorkflowService server listening on https://${this.config.host}:${this.config.port}`);
        this.logAvailableEndpoints();
        resolve();
      });
    });
  }

  public stop(): Promise<void> {
    return new Promise((resolve, reject) => {
      if (this.server) {
        this.server.close((err) => {
          if (err) {
            Logger.error('Error stopping server:', err);
            reject(err);
          } else {
            Logger.info('Server stopped successfully');
            resolve();
          }
        });
      } else {
        resolve();
      }
    });
  }

  private logAvailableEndpoints(): void {
    const baseUrl = `https://${this.config.host}:${this.config.port}`;
    const servicePath = '/workflow.v2.WorkflowService';

    Logger.info('Available endpoints:');
    Logger.info(`  - GET  ${baseUrl}/health`);
    Logger.info(`  - POST ${baseUrl}${servicePath}/CreateWorkflow`);
    Logger.info(`  - POST ${baseUrl}${servicePath}/GetWorkflow`);
    Logger.info(`  - POST ${baseUrl}${servicePath}/UpdateWorkflow`);
    Logger.info(`  - POST ${baseUrl}${servicePath}/DeleteWorkflow`);
    Logger.info(`  - POST ${baseUrl}${servicePath}/ListWorkflows`);
    Logger.info(`  - POST ${baseUrl}${servicePath}/ListWorkflowVersions`);
  }

  public getApp(): express.Application {
    return this.app;
  }
  
  public getServer(): http2.Http2SecureServer {
    return this.server;
  }
}