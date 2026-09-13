export const THREAD_CONFIG = {
    DEFAULT_EXPIRATION_DAYS: 7,
    SNOWFLAKE_EPOCH: 1704067200000
};

export function generateSnowflakeId() {
    return ((Date.now() - THREAD_CONFIG.SNOWFLAKE_EPOCH).toString(2) + Math.floor(Math.random() * 4096).toString(2).padStart(12, '0'));
}

export function createThread(channelId, messageId, threadName, durationDays = THREAD_CONFIG.DEFAULT_EXPIRATION_DAYS) {
    return {
        thread_id: generateSnowflakeId(),
        parent_channel_id: channelId,
        source_message_id: messageId,
        thread_name: threadName,
        created_at: Date.now(),
        expires_at: Date.now() + (durationDays * 86400000),
        status: 'open'
    };
}
