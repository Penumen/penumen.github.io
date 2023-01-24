<?php
if (!array_key_exists('channel', $_REQUEST)) {
    echo 'Empty channel';
    return;
}
if (!array_key_exists('action', $_REQUEST)) {
    echo 'Empty action (get/update)';
    return;
}

$channel = $_REQUEST['channel'];   // Channel username
$file = "{$channel}.watchtime.json";    // File with watchtime

// Open json and collect data
if (file_exists($file)) {
    $data = json_decode(file_get_contents($file), true);
} else {
    $data = [];
}
 if ($_REQUEST['action'] == 'update') {
    // Update watchtime (watchtime.php?channel=streamer&action=update)
    // Do an update only when the target is streaming!
    // You can also insert here a API call to verify it.

    $now = time();  // Epoch time
    if (array_key_exists('$', $data) && $now - $data['$'] < 600) {
        // Increment if only the last update has been made in less than 10 min.
        // This prevents increments when the stream is first loaded.

        // Fetch chatters
        $url = "http://tmi.twitch.tv/group/user/{$channel}/chatters";  // Don't use https here
        $users = json_decode(file_get_contents($url), true)['chatters'];

        // Lazy way to find if the stream is off
        if (empty($users['broadcaster'])) {
            echo 'Empty broadcaster';
            return;
        }

        // This script selects only vips ans viewers, mods watchtimes are not counted.
        $chatters = array_merge($users['mods'], $users['vips'], $users['viewers']);
        // Increment watchtime
        $passed = $now - $data['$'];  // Time passed since last update
        foreach ($chatters as $viewer) {
            if (!array_key_exists($viewer, $data))
                $data[$viewer] = 0;
            $data[$viewer] += $passed;
        }
    }
    $data['$'] = $now;  // Store the epoch time of the update
    file_put_contents($file, json_encode($data));    // Save data
    echo "OK";

} elseif ($_REQUEST['action'] == 'get') {
    // Get watchtime of an user (watchtime.php?channel=streamer&action=get&user=username)

    if (empty($data)) {
        echo 'Empty watchtime, update it first!';
        return;
    }
    if (!array_key_exists('user', $_REQUEST)) {
        echo 'Empty username';
        return;
    }
    define("username", $_REQUEST['user']);
    if (array_key_exists(username, $data)) {
        $passed = time() - $data['$'];
        if ($passed > 600)
            $passed  = 0;
        // Both $data[username] and $passed are integers
        $s = $data[username] + $passed;

        // Parsing seconds to days, hours, mins, secs
        $m = intdiv($s, 60);
        $s -= $m * 60;
        $h = intdiv($m, 60);
        $m -= $h * 60;
        $d = intdiv($h, 24);
        $h -= $d * 24;

        // Show times if only they are greater than zeros
        $args = [];
        if ($d > 0) array_push($args, "{$d} days");
        if ($h > 0) array_push($args, "{$h} hours");
        if ($m > 0) array_push($args, "{$m} minutes");
        if ($s > 0) array_push($args, "{$s} seconds");

        echo username . ' watched  the stream for ' . implode(', ', $args) . '!';
    } else echo 'Invalid username "' . username . '": moderator, too new or nonexistent';
}
?>