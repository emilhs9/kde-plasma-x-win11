.pragma library

// In-memory cache of history and frequencies
var searchHistory = {
  // item_name: { count: N, lastUsed: timestamp, type: "app", cmd: "..." }
};

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

function getItemScore(itemOrName, q, itemType) {
    if (!itemOrName || !q) return 0;
    var name = (typeof itemOrName === "object") ? (itemOrName.name || "") : itemOrName;
    var type = itemType || ((typeof itemOrName === "object") ? itemOrName.type : "app");
    var key = name.toLowerCase().trim();
    var query = q.toLowerCase().trim();
    var hist = searchHistory[key];
    var score = 0;

    // 1. Core Launcher Hierarchy: Applications ALWAYS have highest priority over files
    if (type === "app") {
        score += 350;
    } else if (type === "tool") {
        score += 180;
    } else {
        score += 0; // files get 0 base type bonus
    }

    // 2. Exact match
    if (key === query) {
        score += 300;
    }
    // 3. Exact full prefix match (item starts with query)
    else if (key.indexOf(query) === 0) {
        score += 200;
    }
    else {
        // 4. Word-boundary prefix match: e.g. "Google Antigravity" matches "ant" / "antigravity"
        var words = key.split(/[\s\-_.]+/);
        var wordMatched = false;
        for (var w = 0; w < words.length; w++) {
            if (words[w].indexOf(query) === 0) {
                wordMatched = true;
                break;
            }
        }
        if (wordMatched) {
            score += 190;
        } else if (key.indexOf(query) !== -1) {
            score += 60;
        }
    }

    // Check desktop file name, executable, or description
    if (typeof itemOrName === "object") {
        var desktop = (itemOrName.desktop || "").toLowerCase();
        var cmd = (itemOrName.cmd || "").toLowerCase();
        if (desktop.indexOf("/" + query) !== -1 || desktop.indexOf(query) !== -1) {
            score += 80;
        } else if (cmd.indexOf(query) !== -1) {
            score += 40;
        }
    }

    // 5. Historical frequency and recency weighting
    if (hist) {
        score += hist.count * 30;
        var hoursAgo = (Date.now() - hist.lastUsed) / (1000 * 60 * 60);
        if (hoursAgo < 1) score += 60;
        else if (hoursAgo < 24) score += 25;
    }

    return score;
}

function getTopPrediction(q, allCandidates) {
    if (!q || q.length === 0 || !allCandidates) return null;
    var cleanQ = q.toLowerCase().trim();
    var bestMatch = null;
    var maxScore = -1;

    // Only consider Applications and Tools for top predicted autocompletion (NEVER files/documents)
    for (var i = 0; i < allCandidates.length; i++) {
        var item = allCandidates[i];
        if (item.type === "file") continue; // Never autocomplete a file over apps

        var nameLower = (item.name || "").toLowerCase().trim();
        var score = getItemScore(item, cleanQ, item.type);

        var isMatch = false;
        if (nameLower.indexOf(cleanQ) === 0) {
            isMatch = true;
        } else {
            // Word boundary match: e.g. "Google Antigravity" matches "ant"
            var words = nameLower.split(/[\s\-_.]+/);
            for (var w = 0; w < words.length; w++) {
                if (words[w].indexOf(cleanQ) === 0) {
                    isMatch = true;
                    break;
                }
            }
        }

        // Also match if desktop file name starts with or contains query (e.g. antigravity.desktop)
        if (!isMatch && item.desktop) {
            var dName = item.desktop.toLowerCase();
            if (dName.indexOf("/" + cleanQ) !== -1) {
                isMatch = true;
            }
        }

        if (isMatch && score > maxScore) {
            maxScore = score;
            bestMatch = item;
        }
    }
    return bestMatch;
}
