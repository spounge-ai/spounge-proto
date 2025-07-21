import time
from concurrent import futures
import grpc

from nodus_types import svc, execute, types, direct


class NodusServiceServicer(svc.NodusServiceServicer):
    def ExecuteNode(self, request: execute.ExecuteNodeRequest, context):
        print(f"[Server] Received ExecuteNode request: node_id={request.node_id}")
        return execute.ExecuteNodeResponse(
            execution_id=request.execution_id,
            node_id=request.node_id,
            status=types.EXECUTION_STATUS_COMPLETED,
        )


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=2))
    svc.add_NodusServiceServicer_to_server(NodusServiceServicer(), server)
    server.add_insecure_port("[::]:50053")
    server.start()
    print("[Server] gRPC server started on port 50053")
    return server


if __name__ == "__main__":
    server = serve()
    try:
        while True:
            time.sleep(60 * 60 * 24)   
    except KeyboardInterrupt:
        server.stop(0)
