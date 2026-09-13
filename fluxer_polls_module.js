export function createPoll(channelId, question, options, durationHours = 24) {
    if (!channelId || !question || !options || options.length < 2) {
        throw new Error('Invalid poll parameters.');
    }
    return {
        poll_id: 'poll_' + Math.random().toString(36).substring(2, 11),
        channel_id: channelId,
        question: question,
        options: options.map((opt, idx) => ({ id: idx, text: opt, votes: 0 })),
        created_at: Date.now(),
        expires_at: Date.now() + (durationHours * 3600000),
        closed: false
    };
}

const testPoll = createPoll('CHAN_1', 'Deploy to production?', ['Yes', 'No']);
console.log('Poll module verified:', JSON.stringify(testPoll, null, 2));
