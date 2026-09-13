export function createEvent(channelId, title, startTime, endTime, description = '') {
    if (!channelId || !title || !startTime || !endTime) {
        throw new Error('Missing required event parameters.');
    }
    return {
        event_id: 'evt_' + Math.random().toString(36).substring(2, 11),
        channel_id: channelId,
        title: title,
        description: description,
        start_time: startTime,
        end_time: endTime,
        attendees: [],
        status: 'scheduled'
    };
}

const testEvent = createEvent('CHAN_1', 'Deployment Review', Date.now() + 3600000, Date.now() + 7200000);
console.log('Events module verified:', JSON.stringify(testEvent, null, 2));
