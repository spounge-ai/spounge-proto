import grpc
from google.protobuf.duration_pb2 import Duration

from nodus_types import svc, execute, types, direct


def run_client():
    channel = grpc.insecure_channel("localhost:50053")
    stub = svc.NodusServiceStub(channel)

    request = execute.ExecuteNodeRequest(
        execution_id="exec-456",
        node_id="node-test",
        node_type=types.NODE_TYPE_DIRECT,
        timeout=Duration(seconds=10),
        direct_config=direct.DirectNodeConfig(
            mcp_server_id="server-1",
            tool_name="test-tool",
        ),
    )

    response = stub.ExecuteNode(request)
    print(f"[Client] Response received: node_id={response.node_id}, status={response.status}")


if __name__ == "__main__":
    run_client()
