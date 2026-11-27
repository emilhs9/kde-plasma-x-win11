
.pragma library

// In-memory cache of history and frequencies
var searchHistory = {
  // item_name: { count: N, lastUsed: timestamp, type: "app", cmd: "..." }
};

var prefixTrie = {};

function recordSearchSelection(name, type, cmd, icon, desc) {
    if (!name) return;
    var key = name.toLowerCase().trim();
    var now = Date.now();
    
    if (!searchHistory[key]) {
        searchHistory[key] = {
            name: name,
            count: 1,
            lastUsed: now,
            type: type || "app",
            cmd: cmd || "",
            icon: icon || "",
            desc: desc || ""
        };
    } else {
        searchHistory[key].count += 1;
        searchHistory[key].lastUsed = now;
        if (cmd) searchHistory[key].cmd = cmd;
        if (icon) searchHistory[key].icon = icon;
        if (desc) searchHistory[key].desc = desc;
    }
}

function getItemScore(name, q) {
    var key = name.toLowerCase().trim();
    var hist = searchHistory[key];
    var score = 0;

    // Exact prefix match bonus
    if (key.indexOf(q) === 0) {
        score += 100;
    } else if (key.indexOf(q) !== -1) {
        score += 40;
    }

    // Historical frequency and recency weighting
    if (hist) {
        score += hist.count * 25;
        // Recency bonus: if used in the last 24h
        var hoursAgo = (Date.now() - hist.lastUsed) / (1000 * 60 * 60);
        if (hoursAgo < 1) score += 50;
        else if (hoursAgo < 24) score += 20;
    }

    return score;
}

function getTopPrediction(q, allCandidates) {
    if (!q || q.length === 0) return null;
    var cleanQ = q.toLowerCase().trim();
    var bestMatch = null;
    var maxScore = -1;

    for (var i = 0; i < allCandidates.length; i++) {
        var item = allCandidates[i];
        var nameLower = (item.name || "").toLowerCase().trim();
        
        // Only predict autocomplete if it starts with query
        if (nameLower.indexOf(cleanQ) === 0 && nameLower.length >= cleanQ.length) {
            var score = getItemScore(item.name, cleanQ);
            if (score > maxScore) {
                maxScore = score;
                bestMatch = item;
            }
        }
    }
    return bestMatch;
}
