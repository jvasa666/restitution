export function handleRpcCall(method, params) {
    switch (method) {
        case 'GET_ACTIVITY':
            return { status: 'active', uptime: process.uptime() };
        case 'PING':
            return { response: 'PONG', timestamp: Date.now() };
        default:
            throw new Error(`Unsupported RPC method: ${method}`);
    }
}

const testRpc = handleRpcCall('PING', {});
console.log('RPC module verified:', JSON.stringify(testRpc, null, 2));
